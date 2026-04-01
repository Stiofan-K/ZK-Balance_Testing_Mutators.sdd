if not gadgetHandler:IsSyncedCode() then return end

function gadget:GetInfo()
	return {
		name = "Missile Targetpainter",
		desc = "Makes Missiles seek the target set by their target painting weapon",
		author = "Stiofan",
		date = "1 April 2026",
		license  = "GNU GPL, v2 or later",
		layer = -1,
		enabled = true
	}
end

--[[
	Overkill behaves weird on slow missile and I've yet to get an answer, so I'll work around it in an interesting way.
	BAR's legion faction has a similar thing, FTD also has laser targeted missiles.
	Idea is to have a targeter weapon, that updates the target for missiles
	Could be expanded to becoming unguided when the painter weapon cannot aim/fire
]]

local UNIT = 117 -- unit target id thingy
			
local persistentRetargetMissiles = {}
local onTargetDeathRetargetMissiles = {}
local projectileParents = {}
local projectilePainterWeaponID = {}
local projectilesToRetarget = {}

-- collecting painter defs
local targetPainterDefs = {}
for i = 1,#WeaponDefs do
	local wcp = WeaponDefs[i].customParams
	if wcp and wcp.target_painted then
		targetPainterDefs[i] = {
			targetPainterWeaponID = tonumber(wcp.target_painter_weapon_id) or 1,
			-- Retargeting based on if the target is dead or always target the painters target
			targetPainterPersistentTarget = tonumber(wcp.target_painter_persistent_target) or false,
		}
	end
end


function gadget:Initialize()
	for id, _ in pairs(targetPainterDefs) do
		Script.SetWatchProjectile(id, true)
	end
end

-- on creation, we setup the tables/Arrays depending on needed behavior
function gadget:ProjectileCreated(proID, proOwnerID, weaponID)
	--check if there is targetpainting going on
	if targetPainterDefs[weaponID] then
		local thisTargetPainterDef = targetPainterDefs[weaponID]
		projectilePainterWeaponID[proID] = thisTargetPainterDef.targetPainterWeaponID
		
		--check if its persistent or only retargeting
		-- if it is persistent, then we always retarget
		-- TODO make it do that lol
		if thisTargetPainterDef.targetPainterPersistentTarget then
			persistentRetargetMissiles[proID] = {}
			projectileParents[proID] = proOwnerID
			
		else
			--if it isnt persistent, we only retarget on death of the original unit target
			
			local targetType, targetID = Spring.GetProjectileTarget(proID)
			-- Target should be a valid unit, otherwise I don't think I need to care?
			if targetType == UNIT and Spring.ValidUnitID(targetID) then
				
				-- we store the target unit id, to retarget on the unit's death				
				onTargetDeathRetargetMissiles[proID] = targetID
				projectileParents[proID] = proOwnerID
			end
		end
	end
end

function gadget:ProjectileDestroyed(proID, unitDefID, unitTeam)
	if persistentRetargetMissiles[proID] then
		persistentRetargetMissiles[proID] = nil
	end
	-- clearing the info from onDeath retargeting is a lil more intense if I nest things in a subtable...
	--> I may want to invert my process, and iterate over all projectiles rather than targets for every death?
	--> Feels like thats the more secure way of doing things, even if its less efficent?
	--> perfect is the enemy of good enough, ill go the simpler route.
	if onTargetDeathRetargetMissiles[proID] then
		onTargetDeathRetargetMissiles[proID] = nil
	end
	if projectileParents[proID] then
		projectileParents[proID] = nil
	end
	if projectilePainterWeaponID[proID] then
		projectilePainterWeaponID[proID] = nil
	end
	if projectilesToRetarget[proID] then
		projectilesToRetarget[proID] = nil
	end
end


function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	-- either this feels messy or the projectile destroyed feels mess
	-- we check all projectiles in the array to find a match
	for proID,targetID in pairs(onTargetDeathRetargetMissiles) do
		if targetID == unitID then
			-- on successfull identification, we queue the projectile for retarget
			projectilesToRetarget[proID] = {}
			
		end
	end
end

function gadget:GameFrame(n)
	for proID,_ in pairs(projectilesToRetarget) do	
		local parentUnit = projectileParents[proID]
			
		local targetType, isUserTarget, newtargetID = Spring.GetUnitWeaponTarget(parentUnit, projectilePainterWeaponID[proID])
			
		--returns params instead of unitId when a non unit target, but we don't quite care about that?
		if targetType == 1 and Spring.ValidUnitID(newtargetID) then
			Spring.SetProjectileTarget(proID,newtargetID,117)
		end
	end
end
--[[
function gadget:GameFrame(gameFrame)
	

	
	
	-- Check if we are always targetting the parents weapon
	-- Check if the target is dead
	-- get a new target if the parent unit/weapon has a new target
	
	

end

]]