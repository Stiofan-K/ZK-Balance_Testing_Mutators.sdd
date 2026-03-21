return { amphtankaa = {
  name                   = [[Ballista]],
  description            = [[Disarming Anti-Air Tank]],
  activateWhenBuilt      = true,
  acceleration           = 0.36,
  brakeRate              = 1.8,
  builder                = false,
  buildPic               = [[tankaa.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[HOVER]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[38 52 38]],
  collisionVolumeType    = [[cylY]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 0,
    modelradius    = [[19]],
  },

  explodeAs              = [[BIG_UNITEX]],
  floater                = true,
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1200,
  iconType               = [[shipaa_alt]],
  leaveTracks            = true,
  maneuverleashlength    = [[30]],
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 500,
  movementClass          = [[HOVER3]],
  moveState              = 0,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM LAND SINK TURRET SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName             = [[corsent.s3o]],
  script                 = [[amphtankaa.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  
  sfxtypes               = {

  explosiongenerators = {
      [[custom:HEAVY_CANNON_MUZZLE]],
    },

  },
  sightDistance          = 660,
  sonarDistance          = 660,
  speed                  = 80,
  trackOffset            = 6,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 1044,
  upright                = false,
  waterline              = 14,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[FLAK]],
      --badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },
    {
      def                = [[MISSILE]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs             = {

    FLAK = {
      name                    = [[Disarming Flak Cannon]],
      accuracy                = 50,
      areaOfEffect            = 128,
      burnblow                = true,
      canattackground         = false,
      cegTag                  = [[disarmtrail]],
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargeting       = 1,

      customParams              = {
        disarmDamageMult = 1,
        disarmDamageOnly = 1,
        disarmTimer      = 4,
        
        reaim_time = 1, -- looks silly when rotating otherwise (high turret and body turn rates)
        isaa = [[1]],
        light_radius = 0,
      },

      damage                  = {
        default = 30,
        planes  = 300,
      },

      edgeEffectiveness       = 0.85,
      explosionGenerator      = [[custom:WHITE_LIGHTNING_BOMB]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 1200,
      reloadtime              = 0.8,
      size                    = 0.01,
      soundHit                = [[weapon/missile/vlaunch_emp_hit]],
      soundHitVolume          = 0.5,
      soundStart              = [[weapon/flak_fire]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 2000,
    },
    MISSILE = {
      name                    = [[Heavy Missile]],
      areaOfEffect            = 32,
      canattackground         = false,
      cegTag                  = [[missiletrailblue]],
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargeting       = 1,

      customParams              = {
        burst = Shared.BURST_RELIABLE,

        isaa = [[1]],
        light_color = [[0.5 0.6 0.6]],
      },

      damage                  = {
        default = 29.01,
        planes  = 290.1,
      },

      explosionGenerator      = [[custom:FLASH2]],
      fixedlauncher           = true,
      fireStarter             = 70,
      flightTime              = 3,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_phoenix.s3o]], -- Model radius 150 for QuadField fix.
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 4,
      smokeTrail              = true,
      soundHit                = [[weapon/missile/sabot_hit]],
      soundStart              = [[weapon/missile/missile_fire]],
      startVelocity           = 350,
      texture1                = [[flarescale01]],
      texture2                = [[AAsmoketrail]],
      tolerance               = 9000,
      tracks                  = true,
      turnRate                = 63000,
      turret                  = true,
      weaponAcceleration      = 350,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 800,
    },
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[corsent_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2a.s3o]],
    },

  },

} }
