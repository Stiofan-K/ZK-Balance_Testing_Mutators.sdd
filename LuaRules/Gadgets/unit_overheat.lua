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

--[[
--TODO
-- Theres a few possible ways to go about it. I could do it per unit or per weapon.
-- Per weapon allows for overheat to only affect certain weapons of a unit
-- Per unit makes it easier to read and understand from a player perpective
--> per unit, and allow a weapon custom param to exclude a weapon from it?
--> we are more likely to have only 1 weapon per unit anyways :o

--> so for now, lets define via unitdefs, and allow a weapon to exclude itself

Example Params pilfered from stardust

    heat_per_shot  = 0.035, -- Heat is always a number between 0 and 1
    heat_decay     = 1/6, -- Per second
    heat_max_slow  = 0.5,
    heat_initial   = 1,
]]



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

local function SetupHeat()
	local ud = UnitDefs[unitDefID]
	local cp = ud.customParams
	return tonumber(cp.heat_per_shot), (tonumber(cp.heat_decay) or 0)/Game.gameSpeed, tonumber(cp.heat_max_slow), tonumber(cp.heat_initial) or 0
end
local heatPerShot, heatDecay, heatMaxSlow, currentHeat = SetupHeat()

local function UpdateReloadTime()
	local reloadMult = 1 - currentHeat * heatMaxSlow
	Spring.SetUnitRulesParam(unitID, "selfReloadSpeedChange", reloadMult, LOS_ACCESS)
	Spring.SetUnitRulesParam(unitID, "heat_bar", currentHeat, LOS_ACCESS)
	GG.UpdateUnitAttributes(unitID)
end

local function HeatUpdateThread()
	while currentHeat > 0 do
		UpdateReloadTime()
		Sleep(33)
		local stunned_or_inbuild = Spring.GetUnitIsStunned(unitID)
		if not stunned_or_inbuild then
			local decayMult = (GG.att_EconomyChange[unitID] or 1)
			if decayMult > 0 then
				currentHeat = currentHeat - heatDecay*decayMult
				if currentHeat <= 0 then
					currentHeat = 0
					UpdateReloadTime()
					return
				end
			end
		end
	end
end

local function AddHeat(newHeat)
	local newThread = (currentHeat == 0)

	currentHeat = currentHeat + newHeat
	if currentHeat > 1 then
		currentHeat = 1
	end

	if newThread then
		StartThread(HeatUpdateThread)
	end
end





-- Set innital heat
function gadget:UnitCreated(unitID, unitDefID)
	if HasInnateStealth(unitDefID) then
		spSetUnitStealth(unitID, true)
		for i = 1, #allyTeams do
			Spring.SetUnitLosMask(unitID, allyTeams[i], 2)
		end
	end
end

-- process heat decay
function gadget:GameFrame()
	if not nextSet then
		return
	end
	for i = 1, #nextSet do
		local unitID = nextSet[i]
		if Spring.ValidUnitID(unitID) then
			if not unitErrorParams[unitID] then
				local a, b, c, d, e, f = Spring.GetUnitPosErrorParams(unitID)
				unitErrorParams[unitID] = {a, b, c, d, e, f}
			end
			Spring.SetUnitPosErrorParams(unitID, 0, 0, 0, 0, 0, 0)
		end
	end
	nextSet = false
end