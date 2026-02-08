local base = piece "base"
local door1 = piece "door1"
local door2 = piece "door2"
local missile = piece "missile"
local aimpoint = piece "aimpoint"
local torpfirepoint = piece "aimpoint"

include "constants.lua"

local SIG_AIM = 1

function script.QueryWeapon(num)
	if num == 1 then -- torpedo
		return torpfirepoint
	elseif num == 2 then --tacnuke
		return missile
	end
end

function script.AimFromWeapon(num)
	if num == 1 then -- torpedo
		return torpfirepoint
	elseif num == 2 then --tacnuke
		return aimpoint
	end
end

local respawning_rocket = false

local function RestoreAfterDelay ()
	SetSignalMask (SIG_AIM)
	Sleep (5000)

	while (Spring.GetUnitRulesParam(unitID, "disarmed") == 1) do
		Sleep(100)
	end

	Turn (missile, x_axis, 0, math.rad(30))
	WaitForTurn (missile, x_axis)

	Turn (door1, z_axis, 0, math.rad(20))
	Turn (door2, z_axis, 0, math.rad(20))
end

function script.AimWeapon(num, heading, pitch)
	if num == 1 then -- torpedo
		return true
	elseif num == 2 then --tacnuke
		Signal (SIG_AIM)
		SetSignalMask (SIG_AIM)
		if respawning_rocket then return false end

		while (Spring.GetUnitRulesParam(unitID, "disarmed") == 1) do
			Sleep(100)
		end

		local slowMult = (Spring.GetUnitRulesParam(unitID,"baseSpeedMult") or 1)
		Turn (door1, z_axis, math.rad(90), math.rad(90)*slowMult)
		Turn (door2, z_axis, math.rad(-90), math.rad(90)*slowMult)
		WaitForTurn (door1, z_axis)
		Turn (missile, x_axis, math.rad(-90), math.rad(180)*slowMult)
		WaitForTurn (missile, x_axis)
		StartThread (RestoreAfterDelay)
		return true
	end
end

function script.Shot(num)
	if num == 2 then --tacnuke
		Signal (SIG_AIM)
	end
end

function script.EndBurst(num)
	if num == 2 then --tacnuke
		--[[ NB: hiding the missile is done here rather than in FireWeapon
			partially because a modded unit can have a longer burst, but
			mostly because FireWeapon applies before the projectile is
			actually spawned so the Turn would ruin the spawnpoint, up to
			clipping it into other units or seaside cliffs. ]]
		Hide (missile)
		local slowMult = (Spring.GetUnitRulesParam(unitID,"baseSpeedMult") or 1)
		Turn (missile, x_axis, 0, math.rad(90)*slowMult)
		Turn (door1, z_axis, 0, math.rad(80)*slowMult)
		Turn (door2, z_axis, 0, math.rad(80)*slowMult)
		WaitForTurn (door1, z_axis)

		respawning_rocket = false
		Show(missile)
	end
end

function script.Create()
	Move(torpfirepoint, y_axis, -17, 0)
	Move(torpfirepoint, z_axis, 35, 0)
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	if (severity <= 0.25) then
		return 1
	elseif (severity <= 0.50) then
		Explode (door1, SFX.FALL)
		return 1
	elseif (severity <= 0.75) then
		Explode (base, SFX.SHATTER)
		Explode (door1, SFX.FALL)
		return 2
	else
		Explode (base, SFX.SHATTER)
		Explode (door1, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode (door2, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		return 2
	end
end
