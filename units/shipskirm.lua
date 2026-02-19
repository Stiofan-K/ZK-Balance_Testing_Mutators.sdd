return { shipskirm = {
  name                   = [[Mistral]],
  description            = [[Skirmisher Ship]],
  acceleration           = 0.234,
  activateWhenBuilt      = true,
  brakeRate              = 1.38,
  builder                = false,
  buildPic               = [[shipskirm.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[SHIP]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[34 34 70]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 1,
    turnatfullspeed = [[1]],
    modelradius     = [[24]],
    model_rescale = 1.15,
    selection_scale   = 1.1,
    selectionscalemult = 1.25,
    selectionwidthscalemult = 1.65,
    selectioninherit = 1,
  },


  explodeAs              = [[SMALL_UNITEX]],
  floater                = true,
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 650,
  iconType               = [[shipskirm]],
  metalCost              = 220,
  minWaterDepth          = 10,
  movementClass          = [[BOAT3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM SATELLITE SUB FIXEDWING]],
  objectName             = [[shipskirm.s3o]],
  script                 = [[shipskirm.lua]],
  selfDestructAs         = [[SMALL_UNITEX]],
  sfxtypes               = {

    explosiongenerators = {
      [[custom:MISSILE_EXPLOSION]],
      [[custom:MEDMISSILE_EXPLOSION]],
    },

  },

  sightDistance          = 720,
  sonarDistance          = 720,
  speed                  = 63,
  turninplace            = 0,
  turnRate               = 736,
  waterline              = 4,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[ROCKET]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs             = {

     ROCKET = {
      name                    = [[Rocket Launched Torpedo]],
      areaOfEffect            = 75,
      burst                   = 4,
      burstRate               = 0.2,
      cegTag                  = [[rocket_trail_bar_flameboosted]],
      craterBoost             = 1,
      craterMult              = 2,

      customParams        = {
        child_chain_projectile  = "shipskirm_torpedo",
        child_chain_keep_target = true,
        child_chain_speed       = 0,
        child_chain_flight_time = 10,
        force_ignore_ground     = [[1]],
        light_camera_height     = 1800,
      },
      
      damage                  = {
        default = 100,
        planes  = 100,
      },

      fireStarter             = 70,
      flightTime              = 3.5,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_hailstorm.s3o]],
      noSelfDamage            = true,
      range                   = 610,
      reloadtime              = 7.5,
      smokeTrail              = false,
      soundHit                = [[explosion/ex_med4]],
      soundHitVolume          = 8,
      soundStart              = [[weapon/missile/missile2_fire_bass]],
      soundStartVolume        = 7,
      startVelocity           = 260,
      tracks                  = true,
      trajectoryHeight        = 0.6,
      turnrate                = 0,
      turret                  = true,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 260,
      wobble                  = 4600,
    },
    
    
    TORPEDO = {
      name                    = [[Torpedo]],
      areaOfEffect            = 75,
      burst                   = 4,
      burstRate               = 0.2,
      cegTag                  = [[torpedo_trail]],
      craterBoost             = 1,
      craterMult              = 2,

      customParams        = {
        force_ignore_ground = [[1]],
        light_camera_height = 1800,
      },
      
      damage                  = {
        default = 100,
        planes  = 100,
      },

      fireStarter             = 70,
      flightTime              = 3.5,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_hailstorm.s3o]],
      noSelfDamage            = true,
      range                   = 610,
      reloadtime              = 7.5,
      smokeTrail              = false,
      soundHit                = [[explosion/ex_med4]],
      soundHitVolume          = 8,
      soundStart              = [[weapon/missile/missile2_fire_bass]],
      soundStartVolume        = 7,
      startVelocity           = 10,
      tracks                  = true,
      turnRate                = 5000,
      waterWeapon             = true,
      weaponAcceleration      = 50,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 200,
      wobble                  = 0,
    },

  },


  featureDefs            = {

    DEAD = {
      blocking         = false,
      featureDead      = [[HEAP]],

      footprintX       = 2,
      footprintZ       = 2,
      object           = [[shipskirm_dead.s3o]],
    },


    HEAP = {
      blocking         = false,

      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
