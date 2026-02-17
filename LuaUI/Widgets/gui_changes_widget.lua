function widget:GetInfo() --all hail Hello Widget! thx Googlefrog for the templates c:
	return {
		name = "Changes Widget",
		desc = "Shows a window. That just lists the things I've changed",
		author = "Stiofan",
		date = "13 Feburary 2026",
		license = "GPL",
		layer = 0,
		enabled = true
	}
end

local spectating = Spring.GetSpectatingState()
local allied_teams

local is_RoI = (Spring.GetModOptions().overdrivesharingscheme ~= "0")

local window, fake_window
local name_labels = {}
local roi_labels = {}
local base_labels = {}
local base_income_labels = {}
local od_income_labels = {}

function widget:Initialize()
	local Chili = WG.Chili
	if not Chili then
		widgetHandler:RemoveWidget()
		return
	end

	local window =
		Chili.Window:New {
		caption = "Hello There!",
		x = "20%",
		y = "20%",
		right = "20%",
		bottom = "10%",
		parent = Chili.Screen0,
		classname = "main_window",
		children = {
			Chili.Button:New {
				--from gui_chili_vote.lua by KingRaptor
				width = 15,
				height = 15,
				y = 7,
				right = 7,
				textColor = {1, 1, 1, 0.55},
				caption = "x",
				fontsize = 20,
				tooltip = "Close window",
				align = "center",
				valign = "center",
				OnClick = {
					function()
						window2:Dispose()
						window2 = false
					end
				}
			}
		}
	}

	Chili.ScrollPanel:New {
		x = 4,
		right = 4,
		y = 89,
		bottom = 4,
		parent = window,
		children = {
			Chili.TextBox:New { --TODO IDK HOW CHILI WORKS If this text is too long it gets cut off by the parent window? even with scrolling
				text = "Shield \n" ..
					"-- Felon loses range but gets increased regen that disables when its shield is hit.\n" ..
					"-- Thug gains more shieldhealth, radius and a little more dps.\n" ..
					"-- Outlaw is faster and more tanky. Deals more damage up close and less at its edge.\n" ..
					"\n \n" ..
					"Jump\n" ..
					"-- All jumpbots can jump, but worse than their prime jumpers in speed and recharge. It is primarily a tactical movement, not combat jump.\n" ..
					"-- All new jumps have a windup before jumping. It is meant to be only very slightly faster than walking on flat ground.\n" ..
					"-- Puppy has much shorter jump range and I've tried to not make it not skew raider matchups. It doesnt turn midair either, so can't do instant turn shenanigans.\n" ..
					"\n \n" ..
					"Aerial AA\n" ..
					"-- Swift, Raptor and Trident gain extra hp to survive ground AA. About a 2.2x hp buff. \n" ..
					"\n \n" ..
					"Air to ground\n" ..
					"-- Swift gets extra range and fireangle to allow for more micro.\n" ..
					"-- Magpie becomes an attritional glidebomber. It rearms faster and gains some aoe but loses accurate tracking.\n" ..
					"-- Phoenix has its damage shifted more to afterburn from upfront damage, with the resulting damage being similar, but stacking multiple phoenix being less effective.\n" ..
					"\n \n" ..
					"Ships\n" ..
					"-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.\n" ..
					"\n \n" ..
					"Rovers\n" ..
					"-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown.\n" ..
					"\n \n" ..
					"Dante\n" ..
					"-- Dante is speedier, tankier, but has it's missile salvo is replaced with a shorter range grenade barrage.\n" ..
					"-- It's dgun/missiles/grenades have less afterburn (same as pyro) but set the ground on fire, while its flamer gets the extended duration afterburn its missiles had.\n" ..
					"\n \n" ..
					"Merlin\n" ..
					"-- Merlin gets a lower range alternative Salvo, a SLAM salvo. Imobilises merlin during firing. Reloads are linked.\n" ..
					"-> Risk it for the biscuit! This is potentially very strong, but also risks Merlin since the barrage is only 800 range.\n" ..
					"\n \n" ..
					"Reef\n" ..
					"-- Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.\n" ..
					"\n \n" ..
					"Scylla\n"..
					"-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.\n" ..
					"\n \n" ..
					"QoL/Fix:\n" ..
					"-- Dante tries to prioritises its dgun over shooting other things.\n" ..
					"-- Commanders try to prioritise their dgun too.\n" ..
					"-- New Merlin Salvo too\n",
				fontsize = 15,
				y = 10,
				autosize = true,
				textColor = {1, 1, 1, 1}
			}
		}
	}
	
	Chili.Label:New {
		x = 0,
		y = 40,
		right = 0,
		parent = window,
		align = "center",
		valign = "center",
		caption = "Refumbling Changes:",
		fontsize = 30,
		textColor = {1,1,1,1},
	}
end

--[[
Mod Changes: 

Shield
-- Felon loses range but gets increased regen that disables when its shield is hit. 
-- Thug gains more shieldhealth, radius and a little more dps. 
-- Outlaw is faster and more tanky. Deals more damage up close and less at its edge. 
-> Idea is to make shields trade using their shields the norm, instead of having felon as their shield -> damage converter. The more interactable the shields are the better, and felon makes half the factories not interact with it outside of all-ins.
-> The best idea to come from this is I think extra thug shield range. It was very nice the first time it happend, so I think its a good angle to push.

Jump
-- All jumpbots can jump, but worse than their prime jumpers in speed and recharge. It is primarily a tactical movement, not combat jump.
-- All new jumps have a windup before jumping. It is meant to be only very slightly faster than walking on flat ground.
-- Puppy has much shorter jump range and I've tried to not make it not skew raider matchups. It doesnt turn midair either, so can't do instant turn shenanigans.
-> This is one of those things that can be potentially very scary to have, but are also just too interesting not to have.
-> Can still fire midair. Placeholder and Firewalker range extension is as such possible with jump. Not sure if its too interesting to remove or too strong to not remove.
-> Currently can't jump midair, but I don't have a strong feeling on this. It would be more interesting if they were allowed.

Aerial AA
-- Swift, Raptor and Trident gain extra hp to survive ground AA. About a 2.2x hp buff. 
-> Aerial AA is generally too squishy to be used actively feel like a worthwhile investment. Making them just more durable allows people to just use these units more.
-> Obvious caveat is swift scouting being much harder to stop. BUt I hope that

Air to ground
-- Swift gets extra range and fireangle to allow for more micro.
-> I want to be able to strafe things, its a fantasy swift tries to promise but doesnt deliver on.
-> Potentially op especially with the buff to aerial hp. But I think fighters in general being incentivised instead of pure bombers is desireable.

-- Magpie becomes an attritional glidebomber. It rearms faster and gains some aoe but loses accurate tracking.
-> Very experimental, but with Swift doing anti light duties, and ideally raven doing the sniping duties, magpie can lose its tracking to be become a standoff attrition bomber.
-> An attempt to move magpie out of the frustrating no dodge long range poke role it finds itself in.
-> With stronger Aerial AA, Magpies can maybe be contested better in the sky.

-- Phoenix has its damage shifted more to afterburn from upfront damage, with the resulting damage being similar, but stacking multiple phoenix being less effective.
-> The idea is to make sequencial strikes better than stacking phoenix in one strike. A tradeoff of damage output vs safety of phoenix and time to react.
-> This idea was already present in phoenix, but I'd like to try and push it further. However it commits the sin of having higher than normal burn damage.

Ships
-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.
-> Sirens missiles takes alot of work to get value in base zk. This intends to just have the capability be on demand and as such make it useable.
-> Innital feedback suggest doing away with the autofire missile entirely, but I like having units use their capabilities on their own. Could also have a toggle for the autofire missle.

Veh
-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown.
-> Same thing as Siren. This shouldnt lead to any more dps out of badger, but having the on demand capability could be interesting. 
-> A bit of a questionable change, but I'm curious if we could see interesting active badger use.

Striders
-> Striders currently deliver on their weightclass and powerful feel, but mostly as standoff weapons. They could lean a bit more into delivering on their themes/powerfantasy.
-> Ultimatum, scorpion and detriment feel most fleshed out and fun to interact with. Especially scorp and ultimatum have a very clean space of capability, that feels strong when they are are advantaged and weak when not.
-> The other strider could/should lean stronger into their theme and into closer range combat to make interacting with them more interesting.
-> A good approach could be to reward but not force the closer range combat.

-- Dante is speedier, tankier, but has it's missile salvo is replaced with a shorter range grenade barrage.
-- It's dgun/missiles/grenades have less afterburn (same as pyro) but set the ground on fire, while its flamer gets the extended duration afterburn its missiles had.
-> Get in there dante! This lad really really really feels like he wants to get close. It's never been allowed because it's too good at flinging missiles downrange. Now it's a bit shorter ranged, so can be allowed to be better at closing the distance.
-> This may be a back and forth thing. I can imagine that dante got its longer range barrage exactly because couldnt get close/was skirmed alot. But I'm curious to try this out.

-- Merlin gets a lower range alternative Salvo, a SLAM salvo. Imobilises merlin during firing. Reloads are linked.
-> Risk it for the biscuit! This is potentially very strong, but also risks Merlin since the barrage is only 800 range.
-> With how wobbly missile projectiles work, the sort of shotgun merlin idea was already present, but it could never be too effective due to its overall damage needing to be weighted for its max range.
-> The new Salvo currently burnblows (explodes at max range) to stop range extention from firing at terra pillars, but that could be changed.
-> You can retarget mid salvo, but worse than base merlin can. It may be better to prevent this, but its also something to leave in.

Sea Striders

-- Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.
-> Giving access to a limited unit pool for Reef to make keeps the value of gs and air plant, but allows reef to be selfsufficent. Lots of room for interesting things depending on what planes you give it too.
-> With its bp, its also tempting to use as a reclaiming ship, which may put it in danger, which then could lead to interesting gameplay.

-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.
-> Scylla is already a good unit. But you never really want to risk it, and it is most often a purely anti structure unit.
-> The idea is to make it worthwhile risking just a little, and also to add a long range torpedo unit as something we don't have yet. Having it as a sidearm on scylla makes spamming it inefficent.
-> This implementation of said torpedo does feel interesting enough, by being outrunnable and dodgable by light units, tankable and blockable by tanky units but still being powerfull against squisher targets and if not counteracted correctly. Damage could be weighted further toward single target.


QOL/Fix:
-- Dante tries to prioritises its dgun over shooting other things.
-- Commanders try to prioritise their dgun too.
-- New Merlin Salvo too
-> If theres other things like this feel free to poke. Implementation is more a bandaid however.



TODO
-- Athena gets a Nanoplague Canister Dgun. It revives wrecks hit into neutral zombie units.
-> The idea was giving athena a use outside of backline cheese sort of. It already has powerful build options, but they are rarely used.
-> This gives Athena a unique tool that has can have value on frontlines, while also leaning into the "spec-ops" theme. Reviving a raiding party in the enemy base feels like an interesting thing to do.
-> Theres potential for reclaim farming off of revived units etc. But I think that would be enough effort in setup to

TODO Nanoplague Athena/Engi/Silo/superweapon induced wreck zombie revival.

TODO Mistral rocket -> torp

TODO nimbus gets more accurate when stationary.

TODO what do about navy
Cutter buff?

TODO Raven -> Tankier but less damage (maybe bring magpie back to 900)
785 damage is the lowest we can go to still onetap lotus

TODO Magpie feels a lil off still, can get to 900 hp and maybe a little less wobble/more flight time

TODO Merlin Dgun SLAM salvo Maybe disalow reaiming it?

TODO improve by checking dgun reload too?
TODO check unit commands to prioritise dgun?
TODO Jump anims for jumpbots?
TODO Custom smoke for jumpbots jumps?
is a kitbash atm
TODO Better balance for jumpbot jumps?
Firewalkers jump could be worse


TODO Base zk Github Issueable:
Dgun prioritisation
Jump command retargetting can leave units stuck out of range of a jump but not moving close to jump.

]]
