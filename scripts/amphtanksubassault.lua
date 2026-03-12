include "constants.lua"
include "rockPiece.lua"
local dynamicRockData
include "trackControl.lua"
include "pieceControl.lua"

local base, body, turret1, sleeve1, barrel1, firepoint1, turret2, sleeve2, gun2, firepoint2
	= piece("base", "body", "turret1", "sleeve1", "barrel1", "firepoint1", "turret2", "sleeve2", "gun2", "firepoint2")
	
-- Signal definitions
local SIG_AIM1 = 1
local SIG_AIM2 = 2
local SIG_MOVE = 8
local SIG_ROCK_X = 16
local SIG_ROCK_Z = 32

local ROCK_FIRE_FORCE = 0.06
local ROCK_SPEED = 9
local ROCK_DECAY = -0.18
local ROCK_PIECE = base
local ROCK_MIN = 0.001 --If around axis rock is not greater than this amount, rocking will stop after returning to center.
local ROCK_MAX = 1.5

local hpi = math.pi*0.5

rockData = {
	[x_axis] = {
		piece = ROCK_PIECE,
		speed = ROCK_SPEED,
		decay = ROCK_DECAY,
		minPos = ROCK_MIN,
		maxPos = ROCK_MAX,
		signal = SIG_ROCK_X,
		axis = x_axis,
	},
	[z_axis] = {
		piece = ROCK_PIECE,
		speed = ROCK_SPEED,
		decay = ROCK_DECAY,
		minPos = ROCK_MIN,
		maxPos = ROCK_MAX,
		signal = SIG_ROCK_Z,
		axis = z_axis,
	},
}

local trackData = {
	wheels = {
		large = {piece('wheels1'), piece('wheels6')},
		small = {},
	},
	tracks = {},
	signal = SIG_MOVE,
	smallSpeed = math.rad(480),
	smallAccel = math.rad(80),
	smallDecel = math.rad(100),
	largeSpeed = math.rad(360),
	largeAccel = math.rad(40),
	largeDecel = math.rad(50),
	trackPeriod = 50,
}

for i = 1, 3 do
	trackData.tracks[i] = piece ('tracks' .. i)
end
for i = 2, 5 do
	trackData.wheels.small[i - 1] = piece('wheels' .. i)
end

local gunHeading = 0

local smokePiece = {base, turret1}

local RESTORE_DELAY = 3000
local LARGE_MUZZLE_FLASH_FX = 1024
local HUGE_MUZZLE_FLASH_FX = 1025

local ROCK_X_FIRE_1 = -24

local aimPoints = {
	turret1,
	turret2,
}
local firePoints = {
	firepoint1,
	firepoint2,
}

function RestoreMainGun()
	Sleep(RESTORE_DELAY)
	Turn(turret1, y_axis, 0, math.rad(45))
	Turn(sleeve1, x_axis,  math.rad(-30), math.rad(15))
end

function RestoreSideGun()
	Sleep(RESTORE_DELAY)
	Turn(turret2, y_axis, 0, math.rad(120))
	Turn(sleeve2, x_axis, 0, math.rad(90))
end

function RestoreBarrel()
	Sleep(125)
	Move(barrel1, z_axis, 0, 10)
end

function script.Create()
	dynamicRockData = GG.ScriptRock.InitializeRock(rockData)
	InitiailizeTrackControl(trackData)

	Hide(turret2)
	Hide(sleeve2)
	Hide(gun2)
	
	Turn(sleeve1, x_axis,  math.rad(-30), math.rad(15))

	while (select(5, Spring.GetUnitHealth(unitID)) < 1) do
		Sleep (250)
	end
	StartThread (GG.Script.SmokeUnit, unitID, smokePiece)
end

function script.StartMoving()
	StartThread(TrackControlStartMoving)
end

function script.StopMoving()
	TrackControlStopMoving()
end

-- Weapons
local spGetUnitSeparation = Spring.GetUnitSeparation
function script.BlockShot(num, targetID)
	local x,y,z = Spring.GetUnitPosition(unitID)
	-- blocking rocket if too deep. Using other references to aim from makes it not shoot from water
	-- Theres probably a better way of doing this I suppose
	if num == 1 and y < -35 then
		return true
	end

	--blocking torpedo out of water. Could do fake weapon stuff to launch it instead
	if num == 2 and y > -30 then
		return true
	end

	-- reload check
	local reloadState = Spring.GetUnitWeaponState(unitID, 1, 'reloadState')
	if not (reloadState and (reloadState < 0 or reloadState < Spring.GetGameFrame())) then
		return true
	end

	if Spring.ValidUnitID(targetID) then
		--TODO leftover Cyclopse overkill prevention, redo
		-- TTL at max range determined to be 50f empirically
		-- at projectile speed 270 elmo/s and 450 range
		local framesETA = 50 * (spGetUnitSeparation(unitID, targetID) or 0) / 450
		return GG.OverkillPrevention_CheckBlock(unitID, targetID, 1000.1, framesETA, false, false, true)

	end
	return false
end

function script.AimFromWeapon(num)
	return firepoint1
end

function script.QueryWeapon(num)
	return firepoint1
end

function script.AimWeapon(num, heading, pitch)
	Signal(SIG_AIM1)
	SetSignalMask(SIG_AIM1)

	local x,y,z = Spring.GetUnitPosition(unitID)

	if num == 2 and y > -30 then
		return false
	end

	if pitch <= math.rad(0) then
		pitch = math.rad(0) --prevents clipping, shouldnt be too bad?
	end
	
	Turn(turret1, y_axis, heading, math.rad(60))
	Turn(sleeve1, x_axis, -pitch, math.rad(30))
	WaitForTurn(turret1, y_axis)
	WaitForTurn(sleeve1, x_axis)
	StartThread(RestoreMainGun)
	gunHeading = heading
	return true
end

function script.FireWeapon(num)
	if num == 2 then	
		Spring.SetUnitWeaponState(unitID, 1, 'reloadState', Spring.GetGameFrame()+30*10) --10 second reload
		GG.UpdateUnitAttributes(unitID)
	end
end

function script.Shot(num)
	StartThread(GG.ScriptRock.Rock, dynamicRockData[z_axis], gunHeading, ROCK_FIRE_FORCE)
	StartThread(GG.ScriptRock.Rock, dynamicRockData[x_axis], gunHeading - hpi, ROCK_FIRE_FORCE)
	
	EmitSfx(firepoint1, LARGE_MUZZLE_FLASH_FX)
	Move(barrel1, z_axis, -5)
	StartThread(RestoreBarrel)
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	if (severity < 0.25) then
		Explode(turret1, SFX.SMOKE)
		return 1
	elseif (severity < 0.5) then
		Explode(barrel1, SFX.FALL)
		Explode(gun2, SFX.SHATTER)
		Explode(sleeve1, SFX.FALL)
		Explode(turret1, SFX.SHATTER)
		Explode(turret2, SFX.FALL)
		Explode(body, SFX.SMOKE)
		return 1
	elseif (severity < 1) then
		Explode(barrel1, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		Explode(gun2, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		Explode(sleeve1, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		Explode(turret1, SFX.SHATTER)
		Explode(turret2, SFX.SHATTER)
		return 2
	end
	
	Explode(barrel1, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
	Explode(gun2, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
	Explode(sleeve1, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
	Explode(turret1, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
	Explode(turret2, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
	Explode(body, SFX.SHATTER)
	return 2
end
