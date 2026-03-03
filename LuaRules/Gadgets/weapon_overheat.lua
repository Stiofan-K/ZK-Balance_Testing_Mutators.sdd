if not gadgetHandler:IsSyncedCode() then return end

function gadget:GetInfo()
	return {
		name = "Weapon Overheat",
		desc = "Makes weapons overheat, slowing their reloadtime based on Weapon Custom params",
		author = "Stiofan", -- but also pilfered from Stardust
		date = "1 March 2026",
		license  = "GNU GPL, v2 or later",
		layer = -1,
		enabled = true
	}
end


local overheatWeapons = {}
for i = 1,#WeaponDefs do
	local wcp = WeaponDefs[i].customParams
	if wcp and wcp.overheat then
		overheatWeapons[i] = {
            
            
			childDefID = WeaponDefNames[wcp.child_chain_projectile].id,
			setSpeed = tonumber(wcp.child_chain_speed) or false,
			setFlightTime = tonumber(wcp.child_chain_flight_time) or false, --*12 since ttl is in frames it seems
			maxVerticalFactor = tonumber(wcp.child_max_vertical) or false,
			childKeepTarget = wcp.child_chain_keep_target or false
		}
	end
end