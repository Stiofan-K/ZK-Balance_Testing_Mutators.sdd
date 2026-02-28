return { amphtankcon = {
  name                   = [[Weldur]],
  description            = [[Armed Construction (amph)Tank]],
  acceleration           = 0.4,
  activateWhenBuilt      = true,
  brakeRate              = 18.0,
  buildDistance          = 180,
  builder                = true,

  buildoptions           = {
  },

  buildPic               = [[tankcon.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND SHIP]],
  collisionVolumeOffsets = [[0 6 0]],
  collisionVolumeScales  = [[34 18 46]],
  collisionVolumeType    = [[box]],
  corpse                 = [[DEAD]],

  customParams           = {
    aim_lookahead  = 60,
    aimposoffset   = [[0 0 0]],
    midposoffset   = [[0 -4 0]],
    modelradius    = [[30]],
    selection_scale = 1.5,
    normaltex = [[unittextures/welder_normals.dds]],

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 12.5,
  },

  explodeAs              = [[BIG_UNITEX]],
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 1700,
  iconType               = [[builder]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 185,
  movementClass          = [[HOVER3]],
  moveState              = 0,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName             = [[welder.s3o]],
  script                 = [[amphtankcon.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  showNanoSprqay          = false,
  sightDistance          = 300,
  sonarDistance          = 300,
  speed                  = 63,
  trackOffset            = 3,
  trackStrength          = 6,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 1000,
  waterline              = 12,
  workerTime             = 7.5,

  weapons                = {
    
    {
      def                = [[DEPTHCHARGE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP HOVER]],
    },
    
    {
      def                = [[ROLLED_DEPTHCHARGE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    DEPTHCHARGE = {
      name                    = [[Depth Charge]],
      accuracy                = 3000,
      areaOfEffect            = 64,
      avoidFriendly           = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.5,
      burnblow                = true,
      collideFriendly         = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
      cegTag                  = [[torpedo_trail]],

      customParams = {
        burst = Shared.BURST_RELIABLE,

        stays_underwater = 1,
      },

      damage                  = {
        default = 220.1,
      },

      edgeEffectiveness       = 0.6,

      explosionGenerator      = [[custom:TORPEDOHITHUGE]],
      fixedlauncher           = true,
      groundbounce            = 1,
      edgeEffectiveness       = 0.6,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      interceptedByShieldType = 1,
      model                   = [[depthcharge_big.s3o]],
      numbounce               = 3,
      range                   = 240,
      reloadtime              = 6,
      soundHitDry             = [[explosion/mini_nuke]],
      soundHitWet             = [[explosion/wet/ex_underwater]],
      soundStart              = [[weapon/torp_land]],
      startVelocity           = 75,
      tracks                  = true,
      trajectoryHeight        = 2,
      turnRate                = 22000,
      turret                  = true,
      weaponAcceleration      = 22,
      weaponTimer             = 0.5,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 100,
    },
    
    ROLLED_DEPTHCHARGE = {
      name                    = [[Depth Charge]],
      accuracy                = 3000,
      areaOfEffect            = 64,
      avoidFriendly           = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.5,
      burnblow                = false,
      collideFriendly         = false,
      collideFeature          = false,
      craterBoost             = 0,
      craterMult              = 0,
      cegTag                  = [[torpedo_trail]],

      customParams = {
        burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 220.1,
      },

      edgeEffectiveness       = 0.6,

      explosionGenerator      = [[custom:TORPEDOHITHUGE]],
      fixedlauncher           = true,
      groundbounce            = 1,
      edgeEffectiveness       = 0.6,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      interceptedByShieldType = 1,
      model                   = [[depthcharge_big.s3o]],
      numbounce               = 3,
      range                   = 235,
      reloadtime              = 6,
      soundHitDry             = [[explosion/mini_nuke]],
      soundHitWet             = [[explosion/wet/ex_underwater]],
      soundStart              = [[weapon/torp_land]],
      startVelocity           = 200,
      tracks                  = true,
      trajectoryHeight        = 2,
      turnRate                = 22000,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 200,
    },

  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[welder_dead.s3o]],
      collisionVolumeOffsets        = [[0 -2 0]],
      collisionVolumeScales         = [[34 18 46]],
      collisionVolumeType           = [[box]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3b.s3o]],
    },

  },

} }
