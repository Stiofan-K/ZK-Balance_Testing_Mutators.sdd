return { stridersquire = {
  name                   = [[Squire]],
  description            = [[Medium Weight Combat Strider]],
  acceleration           = 0.314,
  autoheal               = 10,
  brakeRate              = 1.327,
  builder                = false,
  buildPic               = [[striderbantha.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 0 -2]],
  collisionVolumeScales  = [[60 80 60]],
  collisionVolumeType    = [[CylY]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default    = 0,
    extradrawrange        = 400,
    aimposoffset          = [[0 -8 0]],
    midposoffset          = [[0 -8 0]],
    modelradius           = [[17]],
    decloak_footprint     = 5,
    normaltex = [[unittextures/bantha_normals.dds]],

    stats_show_death_explosion = 1,
  },

  explodeAs              = [[ESTOR_BUILDING]],
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 20000,
  iconType               = [[t3skirm]],
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 5000,
  movementClass          = [[KBOT4]],
  noAutoFire             = false,
  noChaseCategory        = [[FIXEDWING SATELLITE SUB DRONE]],
  objectName             = [[Bantha.s3o]],
  selfDestructAs         = [[ESTOR_BUILDING]],
  script                 = [[stridersquire.lua]],
  
  sfxtypes               = {

    explosiongenerators = {
      [[custom:zeusmuzzle]],
      [[custom:zeusgroundflash]],
      [[custom:opticblast_charge]]
    },

  },
  sightEmitHeight        = 60,
  sightDistance          = 700,
  speed                  = 47,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 2,
  trackType              = [[ComTrack]],
  trackWidth             = 42,
  turnRate               = 1166,
  upright                = true,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[HEAVY_BLASTER]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SHIP SINK TURRET FLOAT GUNSHIP FIXEDWING HOVER]],
    },
    {
      def                = [[SONIC]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs             = {

    HEAVY_BLASTER  = {
      name                    = [[Heavy Blaster]],
      areaOfEffect            = 120,
      avoidFeature            = false,
      avoidFriendly           = false,
      avoidGround             = false,
      avoidNeutral            = false,
      coreThickness           = 2.5,
      craterBoost             = 6,
      craterMult              = 14,

      customparams = {
        light_radius = 380,
        light_color = [[0.5 0.95 0]],
        gatherradius = [[192]],
        smoothradius = [[128]],
        smoothmult   = [[0.7]],
        smoothexponent = [[0.8]],
        burst = Shared.BURST_RELIABLE,
        -- no `movestructures` because then they can "dodge" via sudden movement
      },
      
      damage                  = {
        default = 1200.1,
      },

      duration                = 0.05,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:spidercrabe_EXPLOSION]],
      fallOffRate             = 0.1,
      fireStarter             = 10,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      lodDistance             = 10000,
      range                   = 600,
      reloadtime              = 4,
      rgbColor                = [[0.1 1 0]],
      rgbColor2               = [[0.5 0.1 0.2]],
      soundHit                = [[explosion/mini_nuke]],
      soundStart              = [[PulseLaser]],
      soundTrigger            = false,
      sweepfire               = false,
      texture1                = [[largelaser_long]],
      texture2                = [[flare]],
      texture3                = [[largelaser_long]],
      texture4                = [[largelaser_long]],
      thickness               = 9,
      tolerance               = 2000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 1500,
    },
    SONIC         = {
        name                    = [[Sonic Blasters]],
        areaOfEffect            = 70,
        avoidFeature            = true,
        avoidFriendly           = true,
        burnblow                = true,
        corethickness           = 0.5,
        craterBoost             = 0,
        craterMult              = 0,

        customParams            = {
            slot = [[5]],
            muzzleEffectFire = [[custom:HEAVY_CANNON_MUZZLE]],
            miscEffectFire   = [[custom:RIOT_SHELL_L]],
            lups_explodelife = 1.5,
            lups_explodespeed = 0.8,
            light_radius = 240,
        },

        damage                  = {
            default = 300.01,
        },
        
        cegTag                  = [[sonictrail]],
        cylinderTargeting       = 5.0,
        explosionGenerator      = [[custom:sonic]],
        edgeEffectiveness       = 0.5,
        fireStarter             = 150,
        impulseBoost            = 350,
        impulseFactor           = 0.5,
        interceptedByShieldType = 1,
        myGravity               = 0.01,
        noSelfDamage            = true,
        range                   = 400,
        reloadtime              = 1.1,
        soundStart              = [[SonicLow]],
        soundHit                = [[SonicHitLow]],
        soundStartVolume        = 5,
        soundHitVolume          = 9,
        stages                  = 1,
        texture1                = [[sonic_glow2]],
        texture2                = [[null]],
        texture3                = [[null]],
        rgbColor                = {0, 0.5, 1},
        thickness               = 40,

        turret                  = true,
        weaponType              = [[LaserCannon]],
        weaponVelocity          = 700,
        waterweapon             = true,
        duration                = 0.15,
    },
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[bantha_wreck.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris4x4b.s3o]],
    },

  },

} }
