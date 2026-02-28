return { amphtankriot = {
  name                = [[Maelstrom]],
  description         = [[Riot Swarm Missile Tank]],
  activateWhenBuilt   = true,
  acceleration        = 0.132,
  brakeRate           = 0.516,
  builder             = false,
  buildPic            = [[tankriot.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[83 83 83]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    bait_level_default = 0,
    cus_noflashlight  = 1,
    selection_scale   = 0.92,
    set_target_range_buffer = 40,
    normaltex = [[unittextures/corbanish_normals.dds]],

    heat_per_shot  = 0.035, -- Heat is always a number between 0 and 1
    heat_decay     = 1/6, -- Per second
    heat_max_slow  = 0.5,
    heat_initial   = 0,
    
    
    outline_x = 110,
    outline_y = 110,
    outline_yoff = 13.5,
  },

  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 4,
  footprintZ          = 4,
  health              = 1950,
  iconType            = [[tankriot]],
  leaveTracks         = true,
  maxSlope            = 18,
  metalCost           = 500,
  movementClass        = [[HOVER4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[corbanish.s3o]],
  script              = [[amphtankriot.lua]],
  selfDestructAs      = [[BIG_UNITEX]],
  sightDistance       = 400,
  sonarDistance       = 400,
  speed               = 69,
  trackOffset         = 8,
  trackStrength       = 10,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 50,
  turninplace         = 0,
  turnRate            = 568,
  waterline           = 10,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[MICROMISSILES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {
    
    MICROMISSILES      = {
      name                    = [[Wasp Launcher]],
      areaOfEffect            = 48,
      cegTag                  = [[missiletrailyellow]],
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0.2,
      
      damage                  = {
        default = 100.1,
      },

      edgeEffectiveness       = 0.5,
      fireStarter             = 0.2,
      flightTime              = 4,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_hailstorm.s3o]],
      noSelfDamage            = true,
      range                   = 800,
      reloadtime              = 0.2,
      smokeTrail              = true,
      soundHit                = [[weapon/missile/missile_fire12]],
      soundStart              = [[weapon/missile/missile_fire10]],
      startVelocity           = 100,
      tracking                = true,
      tolerance               = 4000,
      turnrate                = 30000,
      turret                  = true,
      --waterWeapon           = true,
      weaponAcceleration      = 600,
      weaponTimer             = 0.2,
      weaponType              = [[StarburstLauncher]],
      weaponVelocity          = 1800,
    },
    
    
  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[corbanish_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
