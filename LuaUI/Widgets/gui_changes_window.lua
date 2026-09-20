function widget:GetInfo()
	return {
		name      = "Changes Widget2",
		desc      = "Shows a change window, hopefully",
		author    = "GoogleFrog (I am just stealing this from the base mod)",
		date      = "23 July 2020",
		license   = "GPL",
		layer     = 0,
		enabled   = true,
	}
end

local window, fake_window


--function widget:Initialize()
	local Chili = WG.Chili
	if not Chili then
		widgetHandler:RemoveWidget()
		return
	end

	local window = Chili.Window:New {
		caption = "Stiofan Balance Refumble",
		x = "30%",
		y = "20%",
		right = "30%",
		bottom = "30%",
		parent = Chili.Screen0,
		classname = "main_window",
		children = {
			Chili.Button:New {
				--from gui_chili_vote.lua by KingRaptor
				width = 15,
				height = 15,
				y = 2,
				right = 7,
				textColor = {1, 1, 1, 0.55},
				caption = "x",
				fontsize = 20,
				tooltip = "Close window",
				align = "center",
				valign = "center",
				OnClick = {
					function()
						window:Dispose()
						window = false
					end
				}
			}
		}
	}

	Chili.ScrollPanel:New {
		x = 4,
		right = 4,
		y = 60,
		bottom = 4,
		parent = window,
		children = {
			Chili.TextBox:New { --TODO IDK HOW CHILI WORKS If this text is too long it gets cut off by the parent window? even with scrolling
				text = 
					"Hiya! Welcome to the Stiofan Balance refumble, an amalgam of ideas and changes. Check the Forum thread/Github repository for a more detailed reasoning for the changes.\n" ..
					"Changes: \n" ..
					" \n" ..
					"Amphtanks: Boat but also car!\n" ..
					"Is a new factory, though currently not quite complete and kitbashed out of existing models and some untextured ones. Is still missing polish in how things play and feel, feedback is welcome.\n" ..
					" \n" ..
					"-- Murderhole:		Depth charge armed constructor. Tosses it on land, seeking in water.\n" ..
					"-- Springald: 		Medium weight light particle burst fire raider. Overheats, cools faster in water.\n" ..
					"-- Hive:			Deploying Swarm Missile/Torpedo Riot amphtank. Overheats but cools faster in water.\n" ..
					"-- Mangonel: 		Depth Charge Launcher skirmisher. Tosses them on land, seeking in water. Has some splash damage.\n" ..
					"-- Ballista:		Disarming Flak Tank with short range missile sidearm.\n" ..
					"-- Arbalest:		Rapidfire Gauss Firesupport. Stops to fire. Has very low line of fire. Overheats.\n" ..
					"-- Anura:			Subsurface Assault Raider. Uses torpedoes underwater and a plasma repeater on land.\n" ..
					"-- Crocodile:		Subsurface Assault Bombard. Fires a Heavy Rocket at surface targets even when submerged on a 10 second reload.\n" ..
					"-- Plaguerat:		Amphibious Terrain-flattening and Nanoplague bomb. 8 bp zombie rezspeed.\n"..
					" \n"..
					"Eco: \n"..
					" Small powerplants are more efficent/better at gridding, with an extra buff to our big powerplants.\n" ..
    				"-- Solar:          Cost: 70 -> 50, E production: 2 -> 1.5, Cost per E efficency:  35 -> 33.3 (so slightly more efficent)		Cost:                  70 -> 50  \n" ..
    				"-- Wind:			Gridrange:    63 -> 89\n" ..
					"-- Geo and up:     E generation: 100% -> 120%\n" ..
    				"-- Pylon:			Cost:   200 -> 300, Health: 1000 -> 1500. Pylon catches a nerf to incentivise the other gridding.\n" ..
    				"	\n" ..
					"Birdsnest: \n"..
					" A plane factory that test some variations for a magpie slot unit. Includes some normal planes to stay on par as an opener to normal airfac.\n" ..
    				"-- Includes normal Planes: Crane, Swift, Raptor, Phoenix, Thunderbird Owl, and Likho.\n" ..
    				"\n" ..
					"Fighters and Trident\n" ..
					"Tankier Aerial AA and some adjustments to make Raptor and swift a lil more interesting.\n" ..
					"-- Raptor, Swift Trident: HP: 100% -> 160% \n" ..
					"-- Raptor: Flak guns instead of Lasers, same DPS but slightly more range\n" ..
					"-- Swift: More Range and fireangle on its laser, to allow for more strafing micro.\n" ..
					" \n" ..
					"Nanoplague: Resurect wrecks into neutral Zombies!\n"..
					"-- Currently Athena, Quake, Plaguerat and Disco Rave Party have/are weapons that apply nanoplague.\n"..
					"-- Revive times are based on the cost of the unit and the buildpower of the used nanoplague. Minimum zombie revive time is 10 seconds.\n" ..
					"-- Zombies are slowed by 0.3. Wrecks have an increasing chance to dissolve instead of reviving the less reclaim remains.\n" ..
					"	\n" ..
					"Striders: Some new things some old, generally trying to allow for more interactive strider use.\n" ..
					"Squire! A Medium Weight Combat Strider. 5k cost, 20k hp and carries a 800 range Heavy Blaster and Sonic sidearms. Model pilfered from Paladin.\n" ..
					"Nebula returns! Drops its shield, health and manoverability in favor of more range, cheaper construction and exceptional sight capability.\n"..
					"--- Functions as a siege and intel platform to cap off an aerial advantage. Best contested by a cloaked AA ambush, or aerial AA units.\n"..
					"-- Athena: Gains 2 Nanoplague weapons with shared cooldown. A wide Aoe 50 bp Nanoplague canister and a dgun 150 bp Nanoplague dart.\n" ..
					"-- The Canister has a wide aoe and resurrects at a speed of 50 bp per second. The Dart has much smaller aoe and resurrects at a speed of 150 bp per second. They share a reload\n" ..
					"-- Merlins fires a higher damage, longer reload and longer salvo time salvo. It immobilizes merlin during firing.\n" ..
					"-- This is a stronger but more vunerable Merlin as it immobilises. Retargeting during the salvo is recommended to cover more area.\n" ..
					"-- Paladin: Fires it's EMP missiles while the burst is off cooldown, similar to how Dante's burst works.\n" ..
					"-- Ultimatum is more tanky 2k -> 3.2k hp. drops it's in combat regen for better out of combat regen 5hp -> 20hp (reaver regen)\n" ..
					" \n" ..
					"Sea Striders:\n"..
					"-- Reef: pads repair faster and it becomes a builder. Can now also build some planes and gunships. Its disarm tacnuke is buffed but more expensive.\n" ..
					"-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.\n" ..
					"-- Shogun is cheaper, 4k cost, to see it used more and see whats fun with it.\n" ..
					" \n" ..
					"For more detailed reasoning, have a look at the modpage or the github readme.\n",
				fontsize = 12,
				y = 10,
				autosize = true,
				textColor = {1, 1, 1, 1}
			},
		}
	}
end
