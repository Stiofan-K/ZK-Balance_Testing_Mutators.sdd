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
		y = 80,
		bottom = 4,
		parent = window,
		children = {
			Chili.TextBox:New { --TODO IDK HOW CHILI WORKS If this text is too long it gets cut off by the parent window? even with scrolling
				text = 
					"Shield \n" ..
					"-- Felon loses range but gets increased shield regen and is speedier\n" ..
					"-- Thug gains more shieldhealth, radius and fires both cannons, though with a longer reload. Slighlty more dps\n" ..
					"-- Outlaw is faster and more tanky. Deals more damage up close and slightly less at its edge.\n" ..
					" \n" ..
					"Jump\n" ..
					"-- All jumpbots can jump, but worse than their prime jumpers in speed and recharge. It is primarily a tactical movement, not combat jump.\n" ..
					"-- All new jumps have a windup before jumping. It is meant to be only very slightly faster than walking on flat ground.\n" ..
					"-- Puppy has much shorter jump range and I've tried to not make it not skew raider matchups. It doesnt turn midair either, so can't do instant turn shenanigans.\n" ..
					" \n" ..
					"Aerial AA\n" ..
					"-- Swift, Raptor and Trident gain extra hp to survive ground AA. About a 2.2x hp buff. Raptor's weapon is swapped for a flak gun of same dps.\n" ..
					"-- Raptor and swift also have an extra maneuver enabled. Potentially looks cool, unsure if effective or good or if it even activates?.\n" ..
					" \n" ..
					"Air to ground\n" ..
					"-- Swift gets extra range and fireangle to allow for more micro.\n" ..
					"-- Magpie becomes an attritional glidebomber. It rearms faster and gains some aoe but loses accurate tracking.\n" ..
					"-- Phoenix has its damage shifted more to afterburn from upfront damage, with the resulting damage being similar, but stacking multiple phoenix being less effective.\n" ..
					" \n" ..
					"Ships\n" ..
					"-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.\n" ..
					"-- Mistrals rockets deploy a torpedo submunition on hit, that tracks the original target. It's original damage is split equally between both projectiles\n" ..
					" \n" ..
					"Rovers\n" ..
					"-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown. Very unsure of this change, but maybe something for the badger enjoyers.\n" ..
					" \n" ..
					"Striders\n" ..
					"-- Athena gains a Nanoplague canister missile and Nanoplague Dart as a dgun. Nanoplague causes wrecks in its aoe to resurect into neutral units. Their behavior is equal that of the Zombies! modoption.\n" ..
					"-- The Canister has a wide aoe and resurrects at a speed of 30 bp per second. The Dart has much smaller aoe and resurrects at a speed of 80 bp per second.\n" ..
					"-- Minimum Revive time is 10 seconds. Canister and Dart share a reload.\n" ..
					" \n" ..
					"-- Dante is speedier and tankier, but has it's missile salvo replaced with a shorter range napalm grenade barrage.\n" ..
					"-- It's dgun/missiles/grenades have less afterburn (same as pyro) but set the ground on fire, while its flamer gets the extended duration afterburn its missiles had.\n" ..
					" \n" ..
					"-- Merlin gets a lower range alternative Salvo, a SLAM salvo. Immobilizes merlin during firing. Reloads are linked.\n" ..
					"-> Risk it for the biscuit! This is potentially strong, but also risks Merlin since the barrage is only 800 range. Manual re-aiming is recommended as mobile units can dodge to an extent.\n" ..
					" \n" ..
					"-- Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.\n" ..
					" \n" ..
					"-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.\n" ..
					" \n" ..
					"Quake \n" ..
					"-- Quake applies Nanoplague, resurecting wrecks in its aoe as neutral units. An alternative usecase for it. 50 bp resurect speed.\n" ..
					" \n" ..
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
-- Felon loses range but gets increased regen that disables when its shield is hit and is speedier. 
-- Thug gains more shieldhealth, radius and fires both cannons, though with a longer reload. Slighlty more dps\n" ..
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
-> Puppy jump range can be reevaluated too. It felt fitting for it is all, but a longer range is maybe better for consitency within the factory.

Aerial AA
-- Swift, Raptor and Trident gain extra hp to survive ground AA. About a 2.2x hp buff. Raptor's weapon is swapped for a flak gun of same dps.
-> Aerial AA is generally too squishy to be used actively feel like a worthwhile investment. Making them just more durable allows people to just use these units more.
-> Obvious caveat is swift scouting being much harder to stop. But I hope that
-> Raptor fights ball very quickly now that theyre so tanky, but its still best for dps. With flak its discouraged/more painful, and its a lil better vs balled things.
-> Could maybe even nerf damage if it becomes good at flak duties :o

-- Raptor and swift also have an extra maneuver enabled. Looks cool, unsure if effective or good.
-> looks cool! nimble fighters are fun too

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
-> noticed that this makes phoenix much worse vs koda an pyro. something to think about.

Ships
-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.
-> Sirens missiles takes alot of work to get value in base zk. This intends to just have the capability be on demand and as such make it useable.
-> Innital feedback suggest doing away with the autofire missile entirely, but I like having units use their capabilities on their own. Could also have a toggle for the autofire missle.

-- Mistrals rockets deploy a torpedo submunition on hit, that tracks the original target. It's damage is split equally between both projectiles
-> Not a clean implementation, as Mistral does not shoot at subsurface targets to deploy the torpedo.
-> The idea is to improve accuracy/damage vs targets that can't dodge well in an interesting way. Mistral was a bit bad at killing Siren fast enough.

Veh
-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown.
-> Same thing as Siren. This shouldnt lead to any more dps out of badger, but having the on demand capability could be interesting. 
-> A bit of a questionable change, but I'm curious if we could see interesting active badger use.

Striders
-> Striders currently deliver on their weightclass and powerful feel, but mostly as standoff weapons. They could lean a bit more into delivering on their themes/powerfantasy while being more interactable.
-> Ultimatum, scorpion and detriment feel most fleshed out and fun to interact with. Especially scorp and ultimatum have a very clean space of capability, that feels strong when they are are advantaged and weak when not.
-> The other strider could/should lean stronger into their theme and into closer range combat to make interacting with them more interesting.
-> A good approach could be to reward but not force the closer range combat.

-- Athena gains a Nanoplague canister missile and Nanoplague Dart as a dgun. Nanoplague causes wrecks in its aoe to resurect into neutral units. Their behavior is equal that of the Zombies! modoption.
-- The Canister has a wide aoe and resurrects at a speed of 30 bp per second. The Dart has much smaller aoe and resurrects at a speed of 80 bp per second.
-- Minimum Revive time is 10 seconds. Canister and Dart share a reload.
-> The idea was to give athena a use outside of backline cheese. It's buildoptions are powerful, but it has too long a leadtime to be a responsive tool for the frontline.
-> This gives Athena a unique tool that can always have value on frontlines, while also leaning into the "spec-ops" theme. With a unqiue reason to have an athena around, its buildoptions also become more accessible.
-> Reviving a raiding party in the enemy base feels like an interesting thing to do. Stalling out an advancing army with your own dead wrecks too.
-> Theres potential for reclaim farming off of revived units etc. But I think that would be enough effort in setup to be okay.
-> Testing shows the nanodart, its aoe is small to where it feels like it can miss to easily. I'll increase both aoe's.

-- Dante is speedier, tankier, but has it's missile salvo is replaced with a shorter range grenade barrage.
-- It's dgun/missiles/grenades have less afterburn (same as pyro) but set the ground on fire, while its flamer gets the extended duration afterburn its missiles had.
-> Get in there dante! This lad really really really feels like he wants to get close. It's never been allowed because it's too good at flinging missiles downrange. Now it's a bit shorter ranged, so can be allowed to be better at closing the distance.
-> This may be a back and forth thing. I can imagine that dante got its longer range barrage exactly because couldnt get close/was skirmed alot. But I'm curious to try this out.
-> After self testing, dante feels more suited for running up and killing things.


-- Merlin gets a lower range alternative Salvo, a SLAM salvo. Imobilises merlin during firing. Reloads are linked.
-> Risk it for the biscuit! This is potentially very strong, but also risks Merlin since the barrage is only 800 range.
-> With how wobbly missile projectiles work, the sort of shotgun merlin idea was already present, but it could never be too effective due to its overall damage needing to be weighted for its max range.
-> The new Salvo currently burnblows (explodes at max range) to stop range extention from firing at terra pillars, but that could be changed.
-> You can retarget mid salvo, but worse than base merlin can. It may be better to prevent this, but its also something to leave in.
-> Feedback suggests people want more omph out of it, so it will get some. Didnt seem gamebreaking yet, but now it may?
-> I've added impulse to merlin and upped damage and aoe slightly. It can't kill minos from full still which is fine imo. Manual aim is still recomended

Sea Striders

-- Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.
-> Giving access to a limited unit pool for Reef to make keeps the value of gs and air plant, but allows reef to be selfsufficent. Lots of room for interesting things depending on what planes you give it too.
-> With its bp, its also tempting to use as a reclaiming ship, which may put it in danger, which then could lead to interesting gameplay.

-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.
-> Scylla is already a good unit. But you never really want to risk it, and it is most often a purely anti structure unit.
-> The idea is to make it worthwhile risking just a little, and also to add a long range torpedo unit as something we don't have yet. Having it as a sidearm on scylla makes spamming it inefficent.
-> This implementation of said torpedo does feel interesting enough, by being outrunnable and dodgable by light units, tankable and blockable by tanky units but still being powerfull against squisher targets and if not counteracted correctly. Damage could be weighted further toward single target.

-- Quake applies Nanoplague, resurecting wrecks in its aoe as neutral units. An alternative usecase for it. 50 bp resurect speed.

QOL/Fix:
-- Dante tries to prioritises its dgun over shooting other things.
-- Commanders try to prioritise their dgun too.
-- New Merlin Salvo too
->(could do this for pala etc too but theres no aiming conflict)
-> If theres other things like this feel free to poke. Implementation is more a bandaid however.

-> Nanoplague has alot of options to play with, and some questions about how it should work. Maybe resurrect bp could stack, or so. 
-> Currently faster rez overrites slower rez, but doesnt take progress into account (Only checks if full reztime would be faster than reztime left).
-> every respawned zombie add its cost in metal to gaia's storage (and double the energy). unsure how this interacts with the zombies modoption
-> As such gaia can produce without needing to have mex or E, but also doesnt have infinite income to farm. And also can threaten to go out of control.

TODO Fix the changelog widget :c
HOW DOES IT WORK?!

TODO Trident torps
It's called trident, cmon.
also fills the subsurface niche for gs, and can run double duty sorta

TODO Scythe area cloak
Smol area cloak, get cloak into cloak earlier, while sidestepping conjurers jankyness

TODO Shogun buff
It should be maybe better shore bombardment

TODO Nanoplague com weapons
Recon and guardian get nanoplague canisters/grenades

Strike and engi get single target nanoplague darts

TODO Nanoplague effects
any rezing wreck needs to display effects
-> its fun to be unsure about what rezzes, but it needs to be clear
-> done that, now always shows if something is rezing, doubleing effects if close to completion
Could be better

TODO com buffs?
I'd like for them to be more viable in general
second com weapon should be a generally good play
It's just too interesting to not have be viable/good

TODO Mistral rocket -> torp improvements
A meh implementation currently, should take another look

TODO nimbus gets more accurate when stationary.

TODO Pavise (Odin drop shields) get to move
More control, easier to protect a push with

TODO Stardust cost buff?
It would be nice to see used a lil more?

TODO what do about navy
Cutter buff? Mistral buff could maybe push siren out of the comfort zone enough

TODO Raven -> Tankier but less damage (maybe bring magpie back to 900)
785 damage is the lowest we can go to still onetap lotus

TODO cheaper solars

TODO make areamex toggle that places wind instead of solar

TODO Merlin Dgun SLAM salvo Maybe disalow reaiming it?
It could maybe have less lead to be more accurate on jinkin targets
maybe a tad more edge effectiveness
OR
More damage but disable reaiming.
-> ended up just adding damage, people said it was not stronk enuff. but I may walk back here

TODO improve by checking dgun reload too?
TODO check unit commands to prioritise dgun?
TODO Jump anims for jumpbots?
TODO Custom smoke for jumpbots jumps?
is a kitbash atm
TODO Better balance for jumpbot jumps?
Firewalkers jump could be worse
Puppy jump could disable its weapon or set it to reload
Puppy jump get blocked by terrain sometimes

TODO Dante groundburn
it may stack and unintentionally do loadsa damage
	

TODO Amphtanks
Amphib veh fac
Overheat as a mechanic, water cools them

Con:		amphib tank with long range sonar? Drone? Torpedo launcher?
Raider:		overheating laser tank, 100 cost?
Riot: 		Prism tank, laser shotgun, overheats make it a turtle! a tankriot like outlaw sorta
Riot alt:	Riot scalpel. More missiles, less aoe, overheats
Skirm: 		Bomb/depthcharge launcher, expensive antiskirm/arty? Veh skirms are difficult 
Assault: 	Bursty halberd? Overheats. Maybe like an AVRE?
Arty: 		Large gauss, overheats
Special: 	rez veh/bp effiecent con
			Avre
Spec Raid:	Sub tank, float below water surface

TODO Nebula
Drop the shield.
Weapons as standoff guns
Drones as freely controlable?
allowed to choose its drones from some gunship and all drones available.

TODO Battlecruiser/Flagships
Expensive omni unit?


TODO Support powers
A building that stockpiles metal for use. There is some base implementation around which is cool

TODO Base zk Github Issueable:
Dgun prioritisation
Jump command retargetting can leave units stuck out of range of a jump but not moving close to jump.

]]
