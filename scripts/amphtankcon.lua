include "constants.lua"

local base, body = piece ('base','body')

-- Doors and Propeller
local  ldoor, rdoor, propeller = piece('ldoor','rdoor','propeller')

-- Wheels
local wheelbase, lwheelchassis, rwheelchassis = piece ('wheelbase', 'lwheelchassis', 'rwheelchassis')
local lwheels = { piece 'lwheel1', piece 'lwheel2', piece 'lwheel3', piece 'lwheel4'}
local rwheels = { piece 'rwheel1', piece 'rwheel2', piece 'rwheel3', piece 'rwheel4'}

-- Turret
local turretweapon,turretbarrel, firepoint = piece ('turretgun','turretbarrel','firepoint')

-- Construction
local turretnano = piece('turretnano')
local nanopoints = { piece 'lnanopoint', piece 'rnanopoint' }
local SIG_BUILD = 1

function script.StartBuilding(heading, pitch)
	Signal (SIG_BUILD)
	Turn (turretnano, z_axis, heading, math.rad(150))
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 1)
end

function script.StopBuilding()
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 0)
	SetSignalMask (SIG_BUILD)
	Sleep (5000)
end

-- Weaponry

local turretweapon, turretbarrel, firepoint = piece ('turretgun','turretbarrel','firepoint')
local SIG_AIM = 2

local TURRET_TURN_SPEED = math.rad(270)
local SLEEVE_TURN_SPEED = math.rad(90)


local function PrioritiseTorpGun()
	torpAim = true
	Sleep(500)
	torpAim = false
end

function script.QueryWeapon(num)
	return firepoint
end

function script.AimFromWeapon(num)
	return firepoint
end

function script.AimWeapon(num, heading, pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	
	Turn(turretweapon, z_axis, heading, TURRET_TURN_SPEED)
	Turn(turretbarrel, x_axis, -pitch, SLEEVE_TURN_SPEED)
	WaitForTurn(turretweapon, z_axis)
	
	-- TODO Restore default would be good
	--StartThread(RestoreAfterDelay)
	
	if num == 1 then
		StartThread(PrioritiseTorpGun)

		
	elseif num == 2 and not torpAim then
		Turn(turretbarrel, x_axis, -pitch, SLEEVE_TURN_SPEED)
		WaitForTurn(turretbarrel, x_axis)
		return true
	else 
		return false
	end
	return true
end

function script.FireWeapon(num)
	if num == 2 then
		Spring.SetUnitWeaponState(unitID, 1, 'reloadState', Spring.GetGameFrame()+30*6) --6 second reload
		GG.UpdateUnitAttributes(unitID)
	end
end

function script.BlockShot(num, targetID)
	-- I just like the astethics of tossing a charge out of the back, even if firing like the cannon would be more effective
	--> Still think the above to be true, but since you now have a turret you should use it
	local reloadState = Spring.GetUnitWeaponState(unitID, 1, 'reloadState')
	return not (reloadState and (reloadState < 0 or reloadState < Spring.GetGameFrame()))
end



-- Misc

local wheelTurnSpeed = 1

function script.StartMoving()
	moving = true
	local x,y,z = Spring.GetUnitVelocity(unitID)
	wheelTurnSpeed = math.sqrt(x*x+y*y+z*z)*10
	
	for i,wheel in ipairs(lwheels) do
		Spin(wheel, x_axis, wheelTurnSpeed)
	end
	for i,wheel in ipairs(rwheels) do
		Spin(wheel, x_axis, wheelTurnSpeed)
	end
	Spin(propeller, y_axis, wheelTurnSpeed*3)
end

function script.StopMoving()
	moving = false
	for i,wheel in ipairs(lwheels) do
		StopSpin(wheel,x_axis)
	end
	for i,wheel in ipairs(rwheels) do
		StopSpin(wheel,x_axis)
	end
	StopSpin(propeller, y_axis)
end

local function AmphibControl(wantAmbhib)
	if wantAmbhib then
		Turn(lwheelchassis, y_axis, -100, math.rad(60))
		Turn(rwheelchassis, y_axis, 100, math.rad(60))
		Move(wheelbase, z_axis, 2.5, 1)
		Turn(ldoor, z_axis, 300, math.rad(60))
		Turn(rdoor, z_axis, -300, math.rad(60))
		WaitForTurn(ldoor, z_axis)
		WaitForTurn(rdoor, z_axis)
		Move(propeller, y_axis, 4, 3)
	else
		Turn(lwheelchassis, y_axis, 0, math.rad(60))
		Turn(rwheelchassis, y_axis, 0, math.rad(60))
		Move(wheelbase, z_axis, 0, 5)
		Move(propeller, y_axis, 0, 5)
		WaitForMove(propeller,y_axis)
		Turn(ldoor, z_axis, 0, math.rad(60))
		Turn(rdoor, z_axis, 0, math.rad(60))
	end
end

local function Wake()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	while true do
		if select(2, Spring.GetUnitPosition(unitID)) <= 0 then			
			StartThread(AmphibControl,true)
			
			if not Spring.GetUnitIsCloaked(unitID) and moving then	
				EmitSfx(propeller, 2)
				EmitSfx(lwheelchassis, 2)
				EmitSfx(rwheelchassis, 2)
			end
		else
			StartThread(AmphibControl,false)
		end
		Sleep(100)
	end
end

function script.Create()
	StartThread(GG.Script.SmokeUnit, unitID, {body})
	Spring.SetUnitNanoPieces(unitID, nanopoints)
	
	local x,y,z = Spring.GetUnitVelocity(unitID)
	wheelTurnSpeed = math.sqrt(x*x+y*y+z*z)*10
	
	moving = false
	StartThread(Wake)
end


local explodables = { turretnano, turretweapon, lwheelchassis, turretbarrel, piece('lwheel1'), ldoor, propeller }
function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	local brutal = severity > 0.5
	for i = 1, #explodables-1 do
		if math.random() < severity then
			Explode(explodables[i], SFX.FALL + (brutal and (SFX.SMOKE + SFX.FIRE) or 0))
		end
	end

	if not brutal then
		return 1
	else
		Explode(body, SFX.SHATTER)
		return 2
	end
end
