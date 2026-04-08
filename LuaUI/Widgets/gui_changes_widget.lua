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

	window =
		Chili.Window:New {
		caption = "Hello There! Changes reordered by relevancy.",
		x = "20%",
		y = "5%",
		right = "20%",
		bottom = "5%",
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
					"Amphtanks! \n" ..
					"-- Tis a new factory, though currently not quite complete and kitbashed out of existing models. Is still missing polish in how things play and feel, feedback is welcome.\n" ..
					" \n" ..
					"-- Murderhole:		Depth charge armed constructor. Tosses it on land, seeking in water.\n" ..
					"-- Springald: 		Medium weight light particle burst fire raider. Overheats, cools faster in water.\n" ..
					"-- Hive:			Deploying Swarm Missile Riot amphtank. Slow to start dealing damage but high dps. Overheats.\n" ..
					"-- Mangonel: 		Depth Charge Launcher skirmisher. Tosses them on land, seeking in water. Has some splash damage.\n" ..
					"-- Ballista:		Disarming Flak Tank with short range missile sidearm.\n" ..
					"-- Arbalest:		Rapidfire Gauss Firesupport. Stops to fire. Has very low line of fire. Overheats.\n" ..
					"-- Anura:			Subsurface Assault Raider. Uses torpedoes underwater and a plasma repeater on land.\n" ..
					"-- Crocodile:		Subsurface Assault Bombard. Fires either a Heavy Rocket on land or Torpedo in water on a 10 second reload.\n" ..
					"-- Plaguerat:		Amphibious Terrain-flattening and Nanoplague bomb. 8 bp zombie rezspeed.\n"..
					" \n"..
					"Striders:\n" ..
					"--> Squire! A Medium Weight Combat Strider. 5k cost, 18k hp and carries a 800 range Heavy Blaster and Sonic sidearms. Model pilfered from Paladin.\n" ..
					"--> Nebula returns! Drops its shield health and manoverability in favor of more range, cheaper construction and exceptional sight capability.\n"..
					"-- Functions as a siege and intel platform to cap off an aerial advantage. Best contested by a cloaked AA ambush, or air units.\n"..
					"--> Athena gains a Nanoplague canister missile and Nanoplague Dart as a dgun.\n" ..
					"-- Nanoplague causes wrecks in its aoe to resurect into neutral units. Their behavior is equal that of the Zombies! modoption. Zombies are slowed by 0.3.\n" ..
					"-- The Canister has a wide aoe and resurrects at a speed of 50 bp per second. The Dart has much smaller aoe and resurrects at a speed of 150 bp per second.\n" ..
					"-- Minimum Revive time is 10 seconds. Canister and Dart share a reload.\n" ..
					"--> Dante is speedier and tankier, but has it's missile salvo replaced with a shorter range napalm grenade barrage.\n" ..
					"-- It's dgun/missiles/grenades have less afterburn (same as pyro) but set the ground on fire, while its flamer gets the extended duration afterburn its missiles had.\n" ..
					"--> Merlin gets a lower range alternative Salvo, a SLAM salvo. Immobilizes merlin during firing. Reloads are linked.\n" ..
					"-- Risk it for the biscuit! This is potentially strong, but also risks Merlin since the barrage is only 900 range. Manual re-aiming is recommended as mobile units can dodge.\n" ..
					"--> Paladin shoots EMP Missiles while its dgun is off cooldown\n" ..
					"--> Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.\n" ..
					"--> Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.\n" ..
					"--> Shogun is cheaper, 4k cost.\n" ..
					" \n" ..
					"Aerial AA\n" ..
					"-- Swift, Raptor and Trident gain extra hp to survive ground AA. About a 1.6x hp buff. Raptor's weapon is swapped for a flak gun of same dps with slightly more range.\n" ..
					"-- Raptor and swift also have an extra maneuver enabled. Potentially looks cool, unsure if effective or good or if it even activates?.\n" ..
					" \n" ..
					"Air to ground\n" ..
					"-- Swift gets extra range and fireangle to allow for more micro.\n" ..
					"-- Magpie becomes an attritional glidebomber. It rearms faster and gains some aoe but loses accurate tracking.\n" ..
					"-- Phoenix has its damage shifted more to afterburn from upfront damage, with the resulting damage being similar, but stacking multiple phoenix being less effective.\n" ..
					" \n" ..
					"Cloak\n" ..
					"-- Scythe can now areacloak, being a middle step between conjurer and iris. Scythe is slowed when areacloaking, but still slightly faster than iris.\n" ..
					" \n" ..
					"Jump\n" ..
					"-- All jumpbots can jump, but worse than their prime jumpers in speed and recharge. It is primarily a tactical movement, not combat jump.\n" ..
					"-- All new jumps have a windup before jumping. It is meant to be only very slightly faster than walking on flat ground.\n" ..
					"-- Puppy has much shorter jump range and I've tried to not make it not skew raider matchups. It doesnt turn midair either, so can't do instant turn shenanigans.\n" ..
					" \n" ..
					"Ships\n" ..
					"-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.\n" ..
					"-- Mistrals rockets deploy a anti surface torpedo submunition on hit, that tracks it's original target. Only capable of targeting surfaced units. It's original damage is split equally between both projectiles.\n" ..
					" \n" ..
					"Shield \n" ..
					"-- Felon loses range but gets increased shield regen and is speedier\n" ..
					"-- Thug gains more shieldhealth, radius and fires both cannons, though with a longer reload. Slighlty more dps\n" ..
					"-- Outlaw is faster and more tanky. Deals more damage up close and slightly less at its edge.\n" ..
					" \n" ..
					"Miscellaneous\n" ..
					"-- Hercules drops units safely. It applies collision damage immunity to units dropped by ejecting or on death.\n" ..
					"-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown. Maybe something for the badger enjoyers.\n" ..
					"-- Bertha has quicker reload but overheats. The first few bertha shots will fire significantly faster before returning to normal reload speed.\n" ..
					"-- Quake applies Nanoplague, resurecting wrecks in its aoe as neutral units. An alternative usecase for it. 50 bp resurect speed.\n" ..
					"-- DRP's green shot also applies nanoplague, at 100 bp.\n" ..
					" \n" ..
					"QoL/Technical/Fix:\n" ..
					"-- Dante tries to prioritises its dgun over shooting other things.\n" ..
					"-- Commanders try to prioritise their dgun too.\n" ..
					"-- New Merlin Salvo too.\n"..
					"-- Overheat is handled in a gadget and could be applied to any unit.",
				fontsize = 13.5,
				y = 10,
				autosize = true,
				textColor = {1, 1, 1, 1}
			},
		}
	}
	
	Chili.Label:New {
		x = 0,
		y = 20,
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

Amphtanks!!
-- Yep, its a new factory, though currently not quite complete and kitbashed out of existing models

-- Murderhole:	Depth charge armed constructor. Tosses it on land
				-> An armed water con. Beats out single raiders or mutliple if they bunch up.
				-> On land it's charge is very dodgeable, but stacks up to be scary enmass.
				-> In water it's tracking
				
-- Springald: 	Medium weight light particle burst raider
				-> A mix of bandit and dagger, a slower more area control focused vehicle raider
				-> I tried overheat, but I don't think it needs it. May still be too strong, hp/range/speed nerf
				
-- Hive:		Swarm Missile Riot amphtank. Slow to start dealing damage.
				-> A backloaded riot unit. Areadenial and good dps/hp. Vunerable to being bursted down.
				-> Now with overheat seems to be settled where I like it.
				-> Feels counterintuitive to a "dps" riot since it slows itself, but the nature of its weapon being almost gurnateed damage is I think alright
				-> Iteration that deploys and retargets it's missiles. Feels more unique now, though the deploy is a 50/50 on if its good or if it were more interesting without
				
-- Mangonel: 	Depth Charge Launcher skirm. Tosses them on land, seeking in water
				-> Slower vehicle based skirmisher with trajectory settings. Expensive and fills an antiskirmisher role
				-> Skirmishes vs underwater units too, but amphbots can outregen their damage decently well.
				-> Depthcharge also doesnt has not alot of flighttime, so doesnt reach raiders that retrat or jink reliably

-- Ballista:	Disarming Flak Tank with short range missile sidearm.
				-> Slower area denial AA that can help out in figher combat
				-> a downside is that it works against bomber ai

-- Arbalest:	Rapidfire Gauss Firesupport. Stops to fire.
				-> Lower range artillery that needs to sit still and line of sight to do damage. Inaccuracy reduces effectiveness against raiders.
				-> Can target subsurface units, but at it's range is still vunerable to countersniping and walling.
				-> Overheats to be balanced?
				-> May need to be turned into more of a bulkhead esque unit. It doesnt seem overpowered, or more powerfull than lance, but it may be more psychologically scary.
				-> Less range and cost seems like an okay tradeoff.
				-> I've finally gotten around and done that. Made overheat more impactfull too
				-> There is also an opportunity for it to just be its overheated version constantly.
				
-- Anura:		Subsurface assault/raider. Uses torpedoes underwater and a plasma repeater on land.
				-> A submarine raider that fights well on shores due to its dual weapon nature.
				-> Steal rangeupdate from duck to accuratly portray the difference
				-> Was more "fun" when it was more equal to ships? I'll not it separatly

-- Crocodile:	Subsurface Assault Bombard. Fires either a Heavy Rocket on land or Torpedo in water on a 10 second reload.
				-> Fires dangerous projectiles both on surface and in water. Still vunerable to swarming due to its long reload.
				-> It's torpedo can be lead and curved back onto allies.
				-> Had to reduce the aoe underwater to make it less monospamable. Though maybe reducing damage and keeping aoe is better to make it countered by large antisup units?
				
-- Plaguebearer: Subsurface Terraform and Nanoplague bomb. Flattens Terrain and revives wrecks as zombies in its aoe. 10 bp rezspeed.
				-> cheaper way to access nanoplague
				-> Also flattens terrain
				-> Silly high impulse could be funny
				
-- Missing qol things like Overkill prevention and tactical ai, which especially hurts the Hive and Mangonel
-- expect to babysit alot more than other factories for now, aswell as missing polish in how things play and feel.
--> Overheat mechanic. I'd like for amphtanks to cool down their heat in water faster, while running hot on land
--> gadget is done, but ive not applied it to everything there. 

Striders
-> Striders currently deliver on their weightclass and powerful feel, but mostly as standoff weapons. They could lean a bit more into delivering on their themes/powerfantasy while being more interactable.
-> Ultimatum, scorpion and detriment feel most fleshed out and fun to interact with. Especially scorp and ultimatum have a very clean space of capability, that feels strong when they are are advantaged and weak when not.
-> The other strider could/should lean stronger into their theme and into closer range combat to make interacting with them more interesting.
-> A good approach could be to reward but not force the closer range combat.

-- Squire
-- A medium weight combat strider. Meant to fill the gap in combat striders between dante n paladin
-> seems conceptually okay. but maybe not a "good" unit

-- Nebula
-- It returns! Drops its shield and health in favor of more range and cheaper construction.
-- Functions as a Siege platform to cap off an aerial advantage.

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
-> After testing, dante feels more suited for running up and killing things.


-- Merlin gets a lower range alternative Salvo, a SLAM salvo. Imobilises merlin during firing. Reloads are linked.
-> Risk it for the biscuit! This is potentially very strong, but also risks Merlin since the barrage is only 800 range.
-> With how wobbly missile projectiles work, the sort of shotgun merlin idea was already present, but it could never be too effective due to its overall damage needing to be weighted for its max range.
-> The new Salvo currently burnblows (explodes at max range) to stop range extention from firing at terra pillars, but that could be changed.
-> You can retarget mid salvo, but worse than base merlin can. It may be better to prevent this, but its also something to leave in.
-> Feedback suggests people want more omph out of it, so it will get some. Didnt seem gamebreaking yet, but now it may?
-> I've added impulse to merlin and upped damage and aoe slightly. It can't kill minos from full still which is fine imo. Manual aim is still recomended

-- Paladin shoots emp missiles when its dgun is on cooldown
-> similar behavior to dante etc, so I feel like its cool here too

Sea Striders

-- Reef's pads repair faster and it becomes a builder. Can now also build some planes and gunships.
-> Giving access to a limited unit pool for Reef to make keeps the value of gs and air plant, but allows reef to be selfsufficent. Lots of room for interesting things depending on what planes you give it too.
-> With its bp, its also tempting to use as a reclaiming ship, which may put it in danger, which then could lead to interesting gameplay.

-- Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.
-> Scylla is already a good unit. But you never really want to risk it, and it is most often a purely anti structure unit.
-> The idea is to make it worthwhile risking just a little, and also to add a long range torpedo unit as something we don't have yet. Having it as a sidearm on scylla makes spamming it inefficent.
-> This implementation of said torpedo does feel interesting enough, by being outrunnable and dodgable by light units, tankable and blockable by tanky units but still being powerfull against squisher targets and if not counteracted correctly. Damage could be weighted further toward single target.


Shield
-- Felon loses range but gets increased regen that disables when its shield is hit and is speedier. 
-- Thug gains more shieldhealth, radius and fires both cannons, though with a longer reload. Slighlty more dps\n" ..
-- Outlaw is faster and more tanky. Deals more damage up close and less at its edge. 
-> Idea is to make shields trade using their shields the norm, instead of having felon as their shield -> damage converter. The more interactable the shields are the better, and felon makes half the factories not interact with it outside of all-ins.
-> The best idea to come from this is I think extra thug shield range. It was very nice the first time it happend, so I think its a good angle to push.

Cloak
-- Scythe can now areacloak, being a middle step between conjurer and iris. It is slightly faster.
-> Scythe being a middle step for cloak, allows them to cloak earlier than other factories.
-> Conjurer could do this but it sort of clashes by being a con, needing extra micro to use well or in armies.


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
-> Aerial AA is generally too squishy to be used actively and feel like a worthwhile investment. Making them just more durable allows people to just use these units more.
-> Obvious caveat is swift scouting being much harder to stop. But I hope that aerial AA being more available makes things easier
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
-> would be okay dropping this change

Ships
-- Siren gains a dgun salvo of its missile, which disables its normal missile during reload.
-> Sirens missiles takes alot of work to get value in base zk. This intends to just have the capability be on demand and as such make it useable.
-> Innital feedback suggest doing away with the autofire missile entirely, but I like having units use their capabilities on their own. Could also have a toggle for the autofire missle.

-- Mistrals rockets deploy a torpedo submunition on hit, that tracks the original target. It's damage is split equally between both projectiles
-> Not a clean implementation, as Mistral does not shoot at subsurface targets to deploy the torpedo.
-> The idea is to improve accuracy/damage vs targets that can't dodge well in an interesting way. Mistral was a bit bad at killing Siren fast enough.
-> the obvious caveate is that it's conflicting messaging

Veh
-- Badger gains a dgun, a burst of mines that puts its main weapon on cooldown.
-> Same thing as Siren. This shouldnt lead to any more dps out of badger, but having the on demand capability could be interesting. 
-> A bit of a questionable change, but I'm curious if we could see interesting active badger use.
-> Hm! Feedback suggest badger feels better to use, and it seems like a stronger opponent too. It definetly allows for more active use.
--> Though it may be too strong. tradeoffs could be made in making its dgun reload longer.


-- Quake applies Nanoplague, resurecting wrecks in its aoe as neutral units. An alternative usecase for it. 50 bp resurect speed.
-- So does DRP's Green shot, at 100 bp

QOL/Technical/Fix:
-- Dante tries to prioritises its dgun over shooting other things.
-- Commanders try to prioritise their dgun too.
-- New Merlin Salvo too
-- Overheat is handled in a gadget an applyable to all units
->(could do this for pala etc too but theres no aiming conflict)
-> If theres other things like this feel free to poke. Implementation is more a bandaid however.

Overheat
-> Overheat is now a gadget that can be applied to all units via custom params
-> Exponential Overheat could be something :o currently its only linear


NanoPlague
-> Nanoplague has alot of options to play with, and some questions about how it should work. Maybe resurrect bp could stack, or so. 
-> Currently faster rez overrites slower rez, but doesnt take progress into account (Only checks if full reztime would be faster than reztime left).
-> every respawned zombie add its cost in metal to gaia's storage (and double the energy). unsure how this interacts with the zombies modoption
-> As such gaia can produce without needing to have mex or E, but also doesnt have infinite income to farm. And also can threaten to go out of control.
-> Some widget guy will make wrecks farmable though

TODO Have a look on how to prevent wreck farming nanoplague
-> have nanoplauge be something you can reclaim off wrecks, maybe as excess E or so
-> no metal drained from the wrecks until the plague is gone.


TODO Fix the changelog widget :c
HOW DOES IT WORK?!
https://github.com/Helwor/New-Hel-K/blob/main/Widgets/Include/helk_core/widgets/addon_chili.lua
function ScrollableTextBox()
	



TODO Paladin
-> cheaper and shorter range?
--> needs to get out of standoff role, or be more interactive in it.
--> I ended up making squire. Pala flings its missiles when dgun is off cooldown

TODO Scythe area cloak?
Smol area cloak, get cloak into cloak earlier, while sidestepping conjurers jankyness
-> done, but not enough testing. maybe op

TODO Shogun buff
It should be maybe better shore bombardment?

TODO Nanoplague com weapons
Recon and guardian get nanoplague canisters/grenades

Strike and engi get single target nanoplague darts
-> comweapons are messy with circuitAi. XNT was working on a fix

TODO Nanoplague effects
any rezing wreck needs to display effects
-> its fun to be unsure about what rezzes, but it needs to be clear
-> done that, now always shows if something is rezing, doubleing effects if close to completion
Could be better?

TODO com buffs?
I'd like for them to be more viable in general
second com weapon should be a generally good play
It's just too interesting to not have be viable/good
-> oh a simple ish tradeoff could be limiting a portion of the coms incom to upgrades (2m per second of the 4 base? or 2 extra?)
-> having a living com is still a metal income advantage, but losing it is less punishing?
-> Metal in coms is already less efficent, so the advantage is less impactful

TODO what do about navy
Mistral buff could maybe push siren out of the comfort zone enough
Vanquisher exists!! could be turned into something
Siren can become a surface focused ship? Hunter and seawolf as only antisub + vanquisher
-> reweapon vanquisher into shotgun torpedo launchers, avoids corsair shotgun confusion

--> Accidentally balanced amphtanks around ships in water. But those matchups were fun!
--> Leads me to believe that it is worthwhile to have amph and hover be on par with ships too, even if that limits ships.
--> So the idea is to bring hover/amph on par in the raider game with ships, and the give ships better tools for later on

Things that would move things in that direction:
-> Duck needs to contest hunter better, currently an unfightable matchup, and could be shuffled over a little

-> Ship's tools past raider phase get better (this is already the case but could improve further)
	-> Vanquisher? big brick unit
	-> Torp mistral?
	Siren and Envoy are sort of ship tier 2
	-> Siren does this quite well.
	-> Envoy does this quite well.
-> Ship's antishore tools get better, to give them reasons to be picked over amph/hover
	-> Envoy does this quite well.
	-> Siren's missiles could get more range still. (could also become a stockpiled thing)
		-> Overkill prevention on sirens missiles
	-> Another arty piece that excells at shore bombardment. Barrage impaler?

TODO Battlecruiser/Flagships
Expensive omni unit?
->Vanquisher exists and could fill that hole
True Subsurface Battlesub?
-> Slow with medium range torps, and water launched missiles?
Toggleable float/sink state?



TODO Mistral rocket -> torp improvements
A meh implementation currently, should take another look
-> fakeweapon shenanigans can give me the result i want
-> maybe should apply it to mangonel too?
-> claymor is another example of other fakeweapon shenanignas

TODO nimbus gets more accurate when stationary.
-> Nimbus is in a meh ish spot at the moment, so thats maybe an idea to get it into a more interesting state?

TODO Pavise (Odin drop shields) get to move
More control, easier to protect a push with.
-> the shields are good enough when you already have an odin, but hard to coordinate for offensive use, and slow to reach a defensive spot

TODO Stardust cost buff?
It would be nice to see used a lil more?
This is more a me change, since i'd like more stable earlygames to get into more diverse midgames


TODO Raven -> Tankier but less damage (maybe bring magpie back to 900)
785 damage is the lowest we can go to still onetap lotus
-> bombers are fun to use, it would be nice to be able to use them more.

TODO cheaper solars
-> more solar walls!
-> gridding becomes too cheap? 
-> Overdrive becomes too cheap?

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

TODO check Dante groundburn
it may stack and unintentionally do loadsa damage
-> though tbh thats fine
-> maybe bigger groundburn aoe
	
TODO Inferno vfx fix for water hit?


TODO Check torps for amphtanks
Heightmod could allow for torp range to scale underwater too

TODO Amphtanks
Amphib veh fac
Overheat as a mechanic, water cools them
-> Need to make overheat gadget

Con:			amphib tank with long range sonar? Drone? Torpedo launcher?
Beaver		Beaver Depth charge welder esque con. Lobs a charge from land. Feels okay.
Raider:			overheating laser tank, 100 cost?
Springald
Chu-Ko-Nu

Riot: 			Prism tank, laser shotgun, overheats make it a turtle! a tankriot like outlaw sorta
Obelisk

Riot alt:		Riot scalpel. More missiles, less aoe, overheats
Hive
TODO			needs overheating and overkill prevention to function as a unit
TODO			Could also make it stop to fire to manover around the  weird overkill bug?

Skirm: 			Bomb/depthcharge launcher, expensive antiskirm/arty? Veh skirms are difficult 
Mangonel		The bigger badger initiative
Onager				Directfire veh skirm, thaat also launches depthcharges, and can optionally high angle
				-> There are probably some hax to fix this, but its good enough atm.

-- Crocodile:	Subsurface Siege Tank. Long Reload Torpedo in water, and Heavy Rocket on Land
->				Seems balanced, but high aoe is soemthing that may be too good
				


Arty: 			Large gauss, overheats
Arbalest		-> rapdifire medium-long range arty, needs to deploy, overheats
				-> has overheat to make it more interesting/less oppressive for continous bombardment
		
				scorpion would be so fitting but its used already :cccccc

AA:				Disarm Flak with short range missile sidearm
Ballista				
				

Special: 		rez veh/bp effiecent con?

Assault: 		Bursty halberd? Overheats. Maybe like an AVRE?
Hulk 			-> could be this facs missing unit o.o"

			
Spec Raid:		Sub tank, float below water surface		
Anura 			Anura/blitz has amhibious modelling
(Frog family)	-> move nose forward and open rear in water, spin fans.
TODO Could be better vs other raiders?
-> is currently the inverse, better vs slower units, gets kited by raiders

-- Bomb			Nanoplague bomb like limpet?

TODO All new units need overkill prevention done righ
sorta done, but not good ig

TODO also need to check for blocked shots
hive loves to punt its shots into a wall

TODO all amphtanks need the water wake effects
Anura/blitz has amhibious modelling
-> move nose forward and open rear in water, spin fans, have rudders out.
-> still needs to spin
-> wake effects attempted for others to medium success.

TODO Mangonel Prioritisation of weapons is iffy to say the least
-> nvm it works!
-> nvm its still meh, ballistics cause the cannon to go beyond torp range and fire instead of the torp
			TODO see if theres a way to force one weapon to be high angle
			TODO At max range the land charge is prefered, because it gets extended range form balistics.
-> I've managed to get it to work decently

TODO Nebula
Drop the shield.
Weapons as standoff guns
Drones as freely controlable?
allowed to choose its drones from some gunship and all drones available.
-> currentl implementation works, but i'd like to still have the drones do their thing


TODO Trident torps
It's called trident, cmon.
also fills the subsurface niche for gs, and can run double duty sorta
-> on a branch for now. It's definetly possible, but making it not too good, while also worthwile is though
-> Unit ai is also conflicting, trying to bring a long range unit in line with cqc stuff
-> dgun is maybe a way, can take advantage of combat range custom param?
-> Depthcharge trident could be its primary purpose? and have a different unit be AA? or the other way around?
-> lots of weeeeird, is meh to work with, needs hax for depthcharge  and land varient
-> lesser claymore like depthcharge is probably prefereable over the spray of smaller ones I had
-> Maybe pure bomb charge
-> primary issue is that it would be a harpy speed riot unit. which just annihalates everything.
-> Maybe a torp implementation is preferable, to lock it to sea use Can take advantage of tridents missile system in place. 
--> urchin also can only target ships, but claymore sets precedent for depthcharges to be land  fireable
-> then maybe torp sidearm, depthcharge dgun that needs trident to rearm at an airpad?
--> that is alot of jank and alot of features for a single unit, and anti atomic units.
-> probably either or for dgun depthcharge or torps or thermite dgun
--> lets keep away from it for now

TODO Support powers
A building that stockpiles metal for use. There is some base implementation around which is cool

TODO Base zk Github Issueable:
Dgun prioritisation
Jump command retargetting can leave units stuck out of range of a jump but not moving close to jump.

]]