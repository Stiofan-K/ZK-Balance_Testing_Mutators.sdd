include "constants.lua"

local  base,   swivel,   turret,   arm,   wrist,   gun,   barrel,   muzzle,   breech,   eject,   steering,   wheel1r,   wheel2r,   wheel1l,   wheel2l,   wheelb = piece(
      'base', 'swivel', 'turret', 'arm', 'wrist', 'gun', 'barrel', 'muzzle', 'breech', 'eject', 'steering', 'wheel1r', 'wheel2r', 'wheel1l', 'wheel2l', 'wheelb')


local aim = false
	  
local function RestoreAfterDelay()
	SetSignalMask(SIG_AIM)
	Sleep(3000)
	Turn(turret, y_axis, 0, math.rad(20))
	Turn(gun   , x_axis, 0, math.rad(20))
	Turn(arm   , z_axis, 0, math.rad(20))
	Turn(wrist , z_axis, 0, math.rad(20))
end

local function Wake()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	while true do
		if not Spring.GetUnitIsCloaked(unitID) and select(2, Spring.GetUnitPosition(unitID)) <= 0 and moving then			
			EmitSfx(wheel1r, 2)
			EmitSfx(wheel2r, 2)
			EmitSfx(wheel1l, 2)
			EmitSfx(wheel2l, 2)
			EmitSfx( wheelb, 2)
		end
		Sleep(200)
	end
end

local function AnimControl()
	SetSignalMask(SIG_MOVE)

	local headingConversion = GG.Script.headingToRad
	local lastHeading = GetUnitValue(COB.HEADING)*headingConversion
	local avgDiffHeading = 0
	while true do
		local currHeading = GetUnitValue(COB.HEADING)*headingConversion
		local diffHeading = currHeading - lastHeading
		if diffHeading > math.pi then
			diffHeading = diffHeading - math.tau
		elseif diffHeading < -math.pi then
			diffHeading = diffHeading + math.tau
		end

		-- smoothing; weights determined empirically
		avgDiffHeading = 0.34 * avgDiffHeading + 0.66 * diffHeading

		Turn(steering, y_axis, -3 * avgDiffHeading, math.rad(180))
		lastHeading = currHeading
		Sleep(100)
	end
end

local function ShotMovement()
	Sleep(1)
	EmitSfx(muzzle, 1024)
	Move(barrel, z_axis, -3.5)
	Move(breech, z_axis, -3)
	Turn(swivel, y_axis, math.rad(60))

	Move(barrel, z_axis, 0, 1.4)
	Move(breech, z_axis, 0, 1.2)
	Turn(swivel, y_axis, 0, math.rad(35))
end

local function PrioritiseTorpGun()
	torpAim = true
	Sleep(500)
	torpAim = false
end

function script.Create()
	moving = false
	StartThread(Wake)
	StartThread(GG.Script.SmokeUnit, unitID, {base, turret, gun})
end

function script.StartMoving()
	Signal(SIG_MOVE)
	Spin(wheel1r, x_axis, math.rad(360), math.rad(10))
	Spin(wheel2r, x_axis, math.rad(360), math.rad(10))
	Spin(wheel1l, x_axis, math.rad(360), math.rad(10))
	Spin(wheel2l, x_axis, math.rad(360), math.rad(10))
	Spin(wheelb , x_axis, math.rad(360), math.rad(10))
	StartThread(AnimControl)
	moving = true
end
function script.StopMoving()
	Signal(SIG_MOVE)
	Turn(steering, y_axis, 0, math.rad(180))
	StopSpin(wheel1r, x_axis, math.rad(50))
	StopSpin(wheel2r, x_axis, math.rad(50))
	StopSpin(wheel1l, x_axis, math.rad(50))
	StopSpin(wheel2l, x_axis, math.rad(50))
	StopSpin(wheelb , x_axis, math.rad(50))
	moving = false
end

function script.AimFromWeapon(num)
	return swivel
end

function script.QueryWeapon(num)
	return muzzle
end

function script.AimWeapon(num, heading, pitch)
	--adjusting aim for torp launcher
	if num == 1 then
		StartThread(PrioritiseTorpGun)
	else
		aim = false
		Signal(SIG_AIM)
		SetSignalMask(SIG_AIM)
		Turn(turret, y_axis, heading, math.rad(180))
		Turn(gun   , x_axis,  -pitch, math.rad(90))
		Turn(arm   , z_axis,   pitch, math.rad(90))
		Turn(wrist , z_axis,  -pitch, math.rad(90))
		WaitForTurn(turret, y_axis)
		WaitForTurn(gun   , x_axis)
		gun_1_yaw = heading
		aim = true
	end
	StartThread(RestoreAfterDelay)
	if aim then
		Turn(turret, y_axis, heading, math.rad(180))
		WaitForTurn(turret, y_axis)
		return true
	end
	return false
end

function script.FireWeapon(num)
	if num == 2 then	
		Spring.SetUnitWeaponState(unitID, 1, 'reloadState', Spring.GetGameFrame()+30*2) --2 second reload
		GG.UpdateUnitAttributes(unitID)
	end
end

function script.EndBurst(num)
	if num then
		StartThread(ShotMovement)
		aim = false
	end
end
	
function script.BlockShot(num, targetID)
	if num == 3 then --Fakeweapon
		return true
	end
		
	if num == 2 and torpAim then
		return true
	end
	local reloadState = Spring.GetUnitWeaponState(unitID, 1, 'reloadState')
	return not (reloadState and (reloadState < 0 or reloadState < Spring.GetGameFrame()))
end

local explodables = {swivel, turret, arm, wrist, gun, barrel, muzzle, breech, eject, steering, wheel1r, wheel2r, wheel1l, wheel2l, wheelb}
function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	local brutal = severity > 0.5
	for i = 1, #explodables do
		if math.random() < severity then
			Explode(explodables[i], SFX.FALL + (brutal and (SFX.SMOKE + SFX.FIRE) or 0))
		end
	end

	if not brutal then
		return 1
	else
		Explode(base, SFX.SHATTER)
		return 2
	end
end