return { amphtanksubraid = {
  name                   = [[Anura]],
  description            = [[Subsurface Assault/Raider Amphtank (Anti-Sub)]],
  acceleration           = 0.75,
  activateWhenBuilt      = true,
  brakeRate              = 1.65,
  builder                = false,
  buildPic               = [[tankheavyraid.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND TOOFAST SINK]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[28 12 28]],
  collisionVolumeType    = [[box]],
  corpse                 = [[DEAD]],

  customParams           = {
    modelradius       = [[10]],
    selection_scale   = 0.85,
    aim_lookahead     = 120,
    bait_level_default = 0,

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 12.5,
  },

  explodeAs              = [[BIG_UNITEX]],
  floater                = true,
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1200,
  iconType               = [[shipraider_alt]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 190,
  movementClass          = [[HOVER3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE]],
  objectName             = [[corseal.s3o]],
  script                 = [[amphtanksubraid.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

  sfxtypes               = {
    explosiongenerators = {
      [[custom:WARMUZZLE]],
      [[custom:emg_shells_l]],
    },
  },

  },
  sightDistance          = 560,
  sonarDistance          = 560,
  speed                  = 90,
  trackOffset            = 6,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 32,
  turninplace            = 0,
  turnRate               = 985,
  waterline              = 45,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[TORPEDO]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
    {
      def                = [[PLASMA_REPEATER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {
      TORPEDO = {

      name                    = [[Torpedo]],
      areaOfEffect            = 32,
      avoidFriendly           = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.5,
      burnblow                = 1,
      canAttackGround         = false, -- workaround for range hax
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,
      cegTag                  = [[torpedo_trail]],

      customParams = {
        burst = Shared.BURST_RELIABLE,

        stays_underwater = 1,
      },

      damage                  = {
        default = 110.1,
      },

      explosionGenerator      = [[custom:TORPEDO_HIT]],
      fixedLauncher           = true,
      groundbounce            = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.5,
      interceptedByShieldType = 1,
      flightTime              = 0.9,
      leadlimit               = 0,
      model                   = [[wep_t_barracuda.s3o]],
      myGravity               = 10.1,
      numbounce               = 4,
      noSelfDamage            = true,
      range                   = 190,
      reloadtime              = 1.5,
      soundHit                = [[TorpedoHitVariable]],
      soundHitVolume          = 2.8,
      soundStart              = [[weapon/torp_land]],
      soundStartVolume        = 4,
      startVelocity           = 300,
      tolerance               = 100000,
      tracks                  = true,
      turnRate                = 200000,
      turret                  = true,
      waterWeapon             = true,
      weaponAcceleration      = 440,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 400,
    },
    
     PLASMA_REPEATER = {
      name                    = [[Plasma Repeater]],
      accuracy                = 350,
      alphaDecay              = 0.7,
      areaOfEffect            = 30,
      burnblow                = true,
      cegTag                  = [[hmg_trail_light]],
      craterBoost             = 0.15,
      craterMult              = 0.3,

      customParams        = {
        reaim_time = 1, -- noticeable twitching otherwise due to huge turnrates
        light_camera_height = 1600,
        light_color = [[0.8 0.76 0.38]],
        light_radius = 150,
        force_ignore_ground = [[1]],
      },

      damage                  = {
        default = 30,
        planes  = 30,
      },

      explosionGenerator      = [[custom:FLASHPLOSION]],
      firestarter             = 70,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 230,
      reloadtime              = 0.3,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 1.5,
      soundHit                = [[weapon/cannon/emg_hit]],
      soundStart              = [[weapon/heavy_emg]],
      stages                  = 10,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 450,
    },
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      collisionVolumeScales = [[28 12 28]],
      collisionVolumeType   = [[box]],
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[corseal_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
