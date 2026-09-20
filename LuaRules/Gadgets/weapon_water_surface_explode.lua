if not gadgetHandler:IsSyncedCode() then return end

function gadget:GetInfo()
	return {
		name = "Water surface explosion",
		desc = "Makes water weapons explode on water surface on reentering.",
		author = "Stiofan",
		date = "1 March 2026",
		license  = "GNU GPL, v2 or later",
		layer = -1,
		enabled = true
	}
end

-- Assumption is that the water Level is 0

local surfaceExplodeProjectiles = {}
local surfaceExplodeWeapons = {}
for i = 1,#WeaponDefs do
	local wcp = WeaponDefs[i].customParams
	if wcp and wcp.water_surface_explode then
		surfaceExplodeWeapons[i] = true
	end
end

function gadget:ProjectileCreated(proID,proOwner,weaponID)
    if surfaceExplodeWeapons[weaponID] then
        surfaceExplodeProjectiles[proID] = 1
    end
end

function gadget:ProjectileDestroyed(proID, unitDefID, unitTeam)
	if surfaceExplodeProjectiles[proID] then
		surfaceExplodeProjectiles[proID] = nil
	end
end

function gadget:GameFrame(f)
    for proID,num in pairs(surfaceExplodeProjectiles) do	
        local x,y,z = Spring.GetProjectilePosition(proID)
        if y <= 0 and num == 2 then
            Spring.SetProjectileCollision(proID)
        end
        if y > 0 and num ~= 2 then
            surfaceExplodeProjectiles[proID] = 2
        end
    end
end

function gadget:Initialize()
	for id, _ in pairs(surfaceExplodeWeapons) do
		Script.SetWatchProjectile(id, true)
	end
end
