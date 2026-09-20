include "constants.lua"

local body, turret, firepoint, firepoint1, shield_back, shield_front, shield_right, shield_left, wheel_1
= piece(
 'hull', 'turret','firepoint10', 'firepoint11', 'shield_1','shield_2','shield_3','shield_4', 'wheel_1'
)


local firstFirepoint = false

local function Wake()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	while true do
		if not Spring.GetUnitIsCloaked(unitID) and select(2, Spring.GetUnitPosition(unitID)) <= 0 and moving then
			EmitSfx(body, 2)
		end
		Sleep(200)
	end
end

local function SpinUp()
	local slowMult = (Spring.GetUnitRulesParam (unitID, "baseSpeedMult") or 1)
	Spin(turret, y_axis, 2*slowMult)
	Sleep(300)
	Spin(turret, y_axis, 5*slowMult)
	Sleep(300)
	Spin(turret, y_axis, 7*slowMult)
end

local function WindDown()
	local slowMult = (Spring.GetUnitRulesParam (unitID, "baseSpeedMult") or 1)
	Spin(turret, y_axis, 4*slowMult)
	Sleep(300)
	Spin(turret, y_axis, 2*slowMult)
	Sleep(300)
	StopSpin(turret,y_axis, 20)
end


local function SetDeploy(wantDeploy)
	if wantDeploy then
		Move(turret, y_axis, 5, 2)
		
		Move(shield_front,z_axis, 0, 2)
		Move(shield_back,z_axis, 0, 2)
		Move(shield_left,x_axis, 0, 2)
		Move(shield_right,x_axis, 0, 2)
		
		Turn(shield_front,x_axis,math.rad(0),math.rad(70))
		Turn(shield_back,x_axis,math.rad(0),math.rad(70))
		Turn(shield_left,z_axis,math.rad(0),math.rad(70))		
		Turn(shield_right,z_axis,math.rad(0),math.rad(70))
	
		StartThread(SpinUp)
		WaitForTurn(shield_right, z_axis, math.rad(0))
		
		if not moving then
			deployed = true
		end
	else
		deployed = false	
		StartThread(WindDown)
		
		Move(turret, y_axis, 0, 2)
	
		Move(shield_front,z_axis, 0.8,2)
		Move(shield_back,z_axis, -0.8,2)
		Move(shield_left,x_axis, -0.8,2)
		Move(shield_right,x_axis, 0.8,2)
		
		Turn(shield_front,x_axis,math.rad(40),math.rad(70))
		Turn(shield_back,x_axis,math.rad(-40),math.rad(70))
		Turn(shield_left,z_axis,math.rad(-40),math.rad(70))		
		Turn(shield_right,z_axis,math.rad(40),math.rad(70))
		
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

function script.QueryWeapon(num)
	return firstFirepoint and firepoint or firepoint1
end

function script.AimFromWeapon(num)
	return firstFirepoint and firepoint or firepoint1
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

function script.Shot(num)
	firstFirepoint = not firstFirepoint
end


function script.Create()
	while (select(5, Spring.GetUnitHealth(unitID)) < 1) do
		Sleep (250)
	end

	Turn(shield_front,x_axis,math.rad(60),math.rad(60))
	Turn(shield_back,x_axis,math.rad(-60),math.rad(60))
	Turn(shield_left,z_axis,math.rad(-60),math.rad(60))		
	Turn(shield_right,z_axis,math.rad(60),math.rad(60))

	Turn(firepoint, x_axis,math.rad(105),0)
	Turn(firepoint1,x_axis,math.rad(105),0)
	Turn(firepoint, y_axis,math.rad(60),0)
	Turn(firepoint1,y_axis,math.rad(60),0)

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
