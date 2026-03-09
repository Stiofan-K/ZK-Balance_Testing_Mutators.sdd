return { amphtankskirm = {
  name                = [[Mangonel]],
  description         = [[Skirmisher/Artillery Depth Charge Launcher (Anti-Sub)]],
  acceleration        = 0.168,
  activateWhenBuilt   = true,
  brakeRate           = 0.96,
  builder             = false,
  buildPic            = [[veharty.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[HOVER]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[63 63 63]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    selection_scale   = 0.85,
    bait_level_default = 0,

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 12.5,
  },

  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  floater             = true,
  health              = 800,
  highTrajectory      = 2,
  iconType            = [[vehiclearty]],
  leaveTracks         = true,
  maneuverleashlength = [[650]],
  maxSlope            = 18,
  maxWaterDepth       = 22,
  metalCost           = 300,
  movementClass       = [[HOVER3]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName          = [[corwolv.s3o]],
  script              = "amphtankskirm.lua",
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:wolvmuzzle0]],
      [[custom:wolvmuzzle1]],
      [[custom:RIOT_SHELL_L]],
    },

  },
  sightDistance       = 570,
  sonarDistance       = 570,
  speed               = 47,
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 30,
  turninplace         = 0,
  turnRate            = 640, --NB: be wary about large turning circles wandering into HLT.
  waterline           = 12,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[DEPTHCHARGE]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },
    {
      def                = [[LAND_DEPTHCHARGE]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },
    {
      def                = [[FAKEWEAPON]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {
    DEPTHCHARGE = {
      name                    = [[Depth Charge Launcher]],
      accuracy                = 700,
      areaOfEffect            = 70,
      avoidFeature            = false,
      avoidGround             = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.5,
      burnblow                = false, 
      cegTag                  = [[torpedo_trail]],
      craterBoost             = 0.2,
      craterMult              = 0.2,
      collideFriendly         = false,
      
      
      customParams            = {
        stays_underwater = 1,
      },
      
      damage                  = {
        default = 220,
        planes  = 220,
      },

      explosionGenerator      = [[custom:FLASH64]],
      fixedLauncher           = true,
      flightTime              = 2,
      groundbounce            = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[depthcharge_big.s3o]],
      myGravity               = 0.15,
      noSelfDamage            = false,
      numbounce               = 4,
      range                   = 570,
      reloadtime              = 3,
      soundHit                = [[weapon/cannon/generic_cannon]],
      soundStart              = [[weapon/cannon/badger_fire]],
      soundHitVolume          = 4,
      soundStartVolume        = 12,
      startVelocity           = 300,
      tracks                  = true,
      turnRate                = 60000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 100,
    },
    
    LAND_DEPTHCHARGE = {
      name                    = [[Land Charge Launcher]],
      accuracy                = 700,
      areaOfEffect            = 144,
      bouncerebound           = 0.2,
      bounceslip              = 0.2,
      burnblow                = false, 
      craterBoost             = 0.2,
      craterMult              = 0.2,
      cegTag                  = [[torpedo_trail]],

      customParams            = {
      },
      
      damage                  = {
        default = 220,
        planes  = 220,
      },

      explosionGenerator      = [[custom:FLASH64]],
      groundbounce            = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[depthcharge_big.s3o]],
      myGravity               = 0.15,
      noSelfDamage            = false,
      numbounce               = 2,
      range                   = 565,
      reloadtime              = 2.5,
      smokeTrail              = true,
      soundHit                = [[weapon/cannon/generic_cannon]],
      soundStart              = [[weapon/cannon/badger_fire]],
      soundHitVolume          = 4,
      soundStartVolume        = 12,
      sprayAngle              = 500,
      startVelocity           = 220,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 300,
    },
    
    FAKEWEAPON = {
      name                    = [[Fake Land Charge Launcher that aims the torp]],
      accuracy                = 700,
      areaOfEffect            = 144,
      avoidFriendly           = true,
      avoidFeature            = false,
      avoidGround             = false,
      bouncerebound           = 0.2,
      bounceslip              = 0.2,
      burnblow                = false, 
      craterBoost             = 0.2,
      craterMult              = 0.2,
      cegTag                  = [[torpedo_trail]],
      
      customParams            = {
      },
      
      damage                  = {
        default = 0,
        planes  = 0,
      },

      explosionGenerator      = [[custom:FLASH64]],
      groundbounce            = 1,
      heightBoostFactor       = 0.0,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[depthcharge_big.s3o]],
      myGravity               = 0.15,
      noSelfDamage            = false,
      numbounce               = 2,
      range                   = 565,
      reloadtime              = 2,
      smokeTrail              = true,
      soundHit                = [[weapon/cannon/generic_cannon]],
      soundStart              = [[weapon/cannon/badger_fire]],
      soundHitVolume          = 4,
      soundStartVolume        = 12,
      sprayAngle              = 500,
      startVelocity           = 220,
      turret                  = true,
      waterweapon             = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 300,
    },

  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[corwolv_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3c.s3o]],
    },

  },

} }
