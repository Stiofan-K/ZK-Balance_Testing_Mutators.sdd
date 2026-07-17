include "constants.lua"

local base, body, turret, shield_back, shield_front, shield_right, shield_left, wheel_1
= piece(
	'base', 'hull', 'turret', 'shield_1','shield_2','shield_3','shield_4', 'wheel_1'
)


local function Wake()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	while true do
		if not Spring.GetUnitIsCloaked(unitID) and select(2, Spring.GetUnitPosition(unitID)) <= 0 and moving then
			EmitSfx(base, 2)
		end
		Sleep(200)
	end
end

local function SpinUp()
	local slowMult = (Spring.GetUnitRulesParam (unitID, "baseSpeedMult") or 1)
	Spin(turret, z_axis, 2*slowMult)
	Sleep(300)
	Spin(turret, z_axis, 5*slowMult)
	Sleep(300)
	Spin(turret, z_axis, 7*slowMult)
end

local function WindDown()
	local slowMult = (Spring.GetUnitRulesParam (unitID, "baseSpeedMult") or 1)
	Spin(turret, z_axis, 4*slowMult)
	Sleep(300)
	Spin(turret, z_axis, 2*slowMult)
	Sleep(300)
	StopSpin(turret,z_axis, 20)
end


local function SetDeploy(wantDeploy)
	if wantDeploy then
		Move(turret, z_axis, 1.5, 2)
		
		Move(shield_front,y_axis, 0, 2)
		Move(shield_back,y_axis, 0, 2)
		Move(shield_left,x_axis, 0, 2)
		Move(shield_right,x_axis, 0, 2)
		
		Turn(shield_front,x_axis,math.rad(0),math.rad(70))
		Turn(shield_back,x_axis,math.rad(0),math.rad(70))
		Turn(shield_left,y_axis,math.rad(0),math.rad(70))		
		Turn(shield_right,y_axis,math.rad(0),math.rad(70))
	
		StartThread(SpinUp)
		WaitForTurn(shield_right, y_axis, math.rad(0))
		
		if not moving then
			deployed = true
		end
	else
		deployed = false	
		StartThread(WindDown)
		
		Move(turret, z_axis, 0, 2)
	
		Move(shield_front,y_axis, 0.8,2)
		Move(shield_back,y_axis, -0.8,2)
		Move(shield_left,x_axis, -0.8,2)
		Move(shield_right,x_axis, 0.8,2)
		
		Turn(shield_front,x_axis,math.rad(-40),math.rad(70))
		Turn(shield_back,x_axis,math.rad(40),math.rad(70))
		Turn(shield_left,y_axis,math.rad(-40),math.rad(70))		
		Turn(shield_right,y_axis,math.rad(40),math.rad(70))
		
	end
end


function script.StartMoving()
	StartThread(SetDeploy,false)
	moving = true
	deployed = false
end

function script.StopMoving()
	StartThread(SetDeploy,true)
	moving = false
end

function script.AimFromWeapon()
	return turret
end

function script.QueryWeapon()
	return turret
end

function script.AimWeapon(num, heading, pitch)
	Signal (SIG_AIM)
	SetSignalMask (SIG_AIM)

	if not deployed or moving then
		return false
	end
	isAiming = true

	while disarmed do
		Sleep (34)
	end


		
	return true
end

function script.Create()
	while (select(5, Spring.GetUnitHealth(unitID)) < 1) do
		Sleep (250)
	end

	Turn(shield_front,x_axis,math.rad(-60),math.rad(60))
	Turn(shield_back,x_axis,math.rad(60),math.rad(60))
	Turn(shield_left,y_axis,math.rad(-60),math.rad(60))		
	Turn(shield_right,y_axis,math.rad(60),math.rad(60))
	

	moving = false
	StartThread(Wake)
	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
end

function script.Killed (recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	if (severity < 0.5) then
		if (math.random() < 2*severity) then Explode (shield_back, SFX.FALL + SFX.FIRE) end
		if (math.random() < 2*severity) then Explode (wheel_1, SFX.FALL + SFX.SMOKE) end
		return 1
	elseif (severity < 0.75) then
		if (math.random() < severity) then
			Explode (turret, SFX.FALL)
		end
		Explode(turret, SFX.FALL)
		Explode(wheel_1, SFX.SHATTER)
		Explode(shield_front, SFX.FALL + SFX.SMOKE)
		Explode(body, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		return 2
	else
		Explode(body, SFX.SHATTER)
		Explode(turret, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode(shield_front, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode(shield_left, SFX.SHATTER)
		Explode(turret, SFX.FALL + SFX.SMOKE)
		Explode(wheel_1, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		return 2
	end
end
