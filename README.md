Hiya! This the Repository for the [Stiofan Balance refumble](https://zero-k.info/Mods/Detail/186). 

Below are the changes listed, for further insight check out the gui_changes_widget.lua.

### Amphtanks: Boat but also car! 
Tis a new factory, though currently not quite complete and kitbashed out of existing models. Is still missing polish in how things play and feel, feedback is welcome.  

    Murderhole:  Depth charge armed constructor. Tosses it on land, seeking in water.  
    Springald:   Medium weight light particle burst fire raider. Overheats, cools faster in water.  
    Hive:        Deploying Swarm Missile Riot amphtank. Slow to start dealing damage but high dps. Overheats.  
    Mangonel:    Depth Charge Launcher skirmisher. Tosses them on land, seeking in water. Has some splash damage.  
    Ballista:    Disarming Flak Tank with short range missile sidearm.  
    Arbalest:    Rapidfire Gauss Firesupport. Stops to fire. Has very low line of fire. Overheats.  
    Anura:       Subsurface Assault Raider. Uses torpedoes underwater and a plasma repeater on land.  
    Crocodile:   Subsurface Assault Bombard. Fires either a Heavy Rocket on land or Torpedo in water on a 10 second reload.  
    Plaguerat:   Amphibious Terrain-flattening and Nanoplague bomb. 8 bp zombie rezspeed.  

### Nanoplague: Resurect wrecks into neutral Zombies!
  Nanoplague is a new weapon effect that causes wrecks hit to resurect into neutral units. Their behavior is equal that of the Zombies! modoption.   
  Zombies propagate and spread their plague if they damage other wrecks.  
  Revive times are based on the cost of  the unit and the buildpower of the used nanoplague. 
  Zombies are slowed by 0.3. Minimum zombie revive time is 10 seconds.
  Wrecks with lower than 50% reclaim left have an increasing chance of dissolving instead of reviving.  
  Currently Athena, Quake, Plaguerat and Disco Rave Party have/are weapons that apply nanoplague.  

### Striders: Some new things some old, generally trying to allow for more interactive strider use.
  Squire! A Medium Weight Combat Strider. 5k cost, 20k hp and carries a 800 range Heavy Blaster and Sonic sidearms. Model pilfered from Paladin.  
  
  Nebula returns! Drops its shield, health and manoverability in favor of more range, cheaper construction and exceptional sight capability. Functions as a siege and intel platform to cap off an aerial advantage. Best contested by a cloaked AA ambush, or aerial AA units.  
  
  Athena gains a Nanoplague canister missile as it's 'regular' weapon and Nanoplague Dart as a dgun. The Canister has a wide aoe and resurrects at a speed of 50 bp per second. The Dart has much smaller aoe and resurrects at a speed of 150 bp per second. They share a reload.  
  
  Merlins fires a higher damage, longer reload and longer salvo time salvo. It immobilizes merlin during firing. This is a stronger but more vunerable Merlin as it immobilises. Retargeting during the salvo is recommended to cover more area.  
  
  Paladin shoots EMP Missiles while its dgun is off cooldown. Makes Paladin a good bit scarier vs normal armies.  
  
  Ultimatum is more tanky 2k -> 3.2k hp. drops it's in combat regen for better out of combat regen 5hp -> 20hp (reaver regen).  
  
  Reef becomes a builder and it's pads repair faster. Can now also build some planes and gunships. Reef's disarm missile is better with longer disarm time, better reload and more disarm damage but are more costly and takes longer to stockpile.  
  
  Scylla gains high damage but slow siege torpedoes that track their target beyond Scyllas fire range. Its tacnuke is moved to a dgun.  
  
  Shogun is cheaper at 4k cost, to see it used more and see whats fun with it.  

### Planes: Tankier fighters to allow for projection of air superiority even with ground AA presence. Some experiments to push planes further into distinct niches.
  Swift, Raptor and Trident gain extra hp to survive ground AA. About a 1.6x hp buff. 
  Raptor's weapon is swapped for a flak gun of same dps with slightly more range.  
  Raptor and swift also have an extra maneuver enabled. Looks cool, unsure if effective or a good addition.  
  Swift gets extra range and fireangle to give more wiggleroom for strafing run micro.    
  Phoenix has its damage shifted more to afterburn from upfront damage, with the resulting damage being similar, but stacking multiple phoenix being less effective.
  
## Experimental Second Air factory: Variations on what could take the Magpie slot. 
  Pidgeon: Large Aoe Toss Bomber.
  Finch: Cluster Toss Bomber
  Falcon: Rocket Strike Bomber
  Heron: Gun Strafing Strikecraft
  Buzzard: A Magpie variation trading basedamage for slow
  Hawk: A Magpie variation trading health for radar stealth.

### Jump: All jump bots can jump
  All jumpbots can jump, but worse than their prime jumpers in speed and recharge. It is primarily a tactical movement, not combat jump.  
  All new jumps have a windup before jumping. It is meant to be only very slightly faster than walking on flat ground.  
  Puppy has much shorter jump range and I've tried to not make it not skew raider matchups. It doesnt turn midair either, so can't do instant turn shenanigans.  

### Economy: Trying to make early gridding easier and more viable. Also Solar walls are encouraged.
  Fusion, Singularity and Geothermals produce 20% more energy.  
  Wind/Tidal Grid range is increased to match solars.  
  Solars are cheaper and produce less energy in turn, ending with a slightly better cost to E ratio than before.  
  Energy Pylons are more expensive but tankier.  

### Miscellaneous: Experimental capabilities to give these units some more utility and depth.
  Scythe can now areacloak, being a middle step between conjurer and iris. Scythe is slowed when areacloaking, but still slightly faster than iris, giving cloakfactory a potential edge in cloaking over morphed iris.  
  
  Hercules drops units safely. It applies collision damage immunity for a little while to units dropped by ejecting or on death.  
  
  Badger gains a dgun, a burst of mines that puts its main weapon on cooldown. Maybe something for the badger enjoyers.  
  
  Bertha has quicker reload but overheats. The first few bertha shots will fire faster before returning to normal reload speed.  
  
  Quake applies Nanoplague as an alternative usecase. 50 bp resurect speed.  
  
  DRP's green shot also applies nanoplague, at 200 bp.  

### Shield: Some shield changes to make it play more brawly.
  Felon loses range but gets increased shield regen and is speedier.  
  Thug gains slightly more shieldhealth, radius and fires both cannons in a burst with a longer reload. Slighlty more dps.  
  Outlaw is faster and more tanky. Deals more damage up close and slightly less at its edge.  

### Ships: More easily usable Siren Missiles and experimental Mistral submunition.
  Siren gains a dgun salvo of its missile, which disables its normal missile during reload.  
  Mistrals rockets deploy a anti surface torpedo submunition on hit, that tracks it's original target.   
    -> Only capable of targeting surfaced units. It's original damage is split equally between both projectiles.  

### QoL/Technical/Fix:
  Commanders try to prioritise their dgun.  
