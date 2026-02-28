include "constants.lua"

local base, nano, guns, doors, turret, shovel = piece ('base', 'nano', 'guns', 'doors', 'turret', 'shovel')

-- Construction

local nanos = { piece 'nano1', piece 'nano2' }
local SIG_BUILD = 1

function script.StartBuilding(heading)
	Signal (SIG_BUILD)
	Turn (doors, x_axis, math.rad(-100), math.rad(200))
	Move (nano, z_axis, 3, 12)
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 1)
end

function script.StopBuilding()
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 0)
	SetSignalMask (SIG_BUILD)
	Sleep (5000)
	Turn (doors, x_axis, 0, math.rad(200))
	Move (nano, z_axis, 0, 12)
end

-- Weaponry

local flares = { piece 'flare1', piece 'flare2' }
local current_flare = 1
local SIG_AIM = 2

function script.QueryWeapon(num)
	return turret
end

function script.AimFromWeapon(num)
	return turret
end

function script.AimWeapon(num, heading, pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	return true
end

function script.FireWeapon(num)
	if num == 2 then
		Spring.SetUnitWeaponState(unitID, 1, 'reloadState', Spring.GetGameFrame()+30*6) --30 second reload
		GG.UpdateUnitAttributes(unitID)
	end
end
function script.BlockShot(num, targetID)
	local x,y,z = Spring.GetUnitPosition(unitID)
	if num == 1 and y > -8 then
		return true
	end
	
	local reloadState = Spring.GetUnitWeaponState(unitID, 1, 'reloadState')
	return not (reloadState and (reloadState < 0 or reloadState < Spring.GetGameFrame()))
end



-- Misc

function script.Create()
	Hide(guns)
	Hide(turret)
	--setting up turret as firepoint
	Turn(turret, x_axis, 90)
	Turn(turret, y_axis, math.rad(-20))
	
	Move(turret, y_axis, 0)
	Move(turret, z_axis, -6)
	Move(turret, x_axis, 2)
	
	StartThread(GG.Script.SmokeUnit, unitID, {base})
	Spring.SetUnitNanoPieces(unitID, nanos)
end

local explodables = { shovel }
function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	local brutal = (severity > 0.5)

	for i = 1, #explodables do
		if math.random() < severity then
			Explode (explodables[i], SFX.FALL + (brutal and (SFX.SMOKE + SFX.FIRE) or 0))
		end
	end

	if not brutal then
		return 1
	else
		Explode (base, SFX.SHATTER)
		return 2
	end
end
