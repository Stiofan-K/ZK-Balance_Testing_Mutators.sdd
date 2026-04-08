return { striderarty = {
  name                   = [[Merlin]],
  description            = [[Heavy Saturation Artillery Strider]],
  acceleration           = 0.328,
  brakeRate              = 1.165,
  builder                = false,
  buildPic               = [[striderarty.png]],
  canGuard               = true,
  canManualFire          = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[65 65 65]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 2,
    normaltex = [[unittextures/Catapult_normals.dds]],
    manualfire_desc = [[Fire Alternative Salvo: Fire a shorter ranged S.L.A.M. Rocket Salvo.]]
  },

  explodeAs              = [[ATOMIC_BLASTSML]],
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 3140,
  iconType               = [[t3arty]],
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 3500,
  movementClass          = [[KBOT4]],
  moveState              = 0,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName             = [[catapult.s3o]],
  script                 = [[striderarty.lua]],
  selfDestructAs         = [[ATOMIC_BLASTSML]],
  sightDistance          = 660,
  speed                  = 36,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 36,
  turnRate               = 1188,
  upright                = true,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[ROCKET]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
    },
    {
      def                = [[SLAM_SALVO]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
    },

  },


  weaponDefs             = {

ROCKET = {
      name                    = [[Long-Range Rocket Battery]],
      areaOfEffect            = 128,
      avoidFeature            = false,
      avoidGround             = false,
      burst                   = 20,
      burstrate               = 0.1,
      cegTag                  = [[RAVENTRAIL_Light]],
      craterBoost             = 1,
      craterMult              = 2,
      
      customParams              = {
        force_ignore_ground = [[1]],
        light_camera_height = 2500,
        light_color = [[0.35 0.17 0.04]],
        light_radius = 400,
        burst = Shared.BURST_UNRELIABLE,
      },
      
      damage                  = {
        default = 220.5,
        planes  = 220.5,
      },

      dance                   = 20,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:MEDMISSILE_EXPLOSION]],
      fireStarter             = 100,
      flightTime              = 8,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[hobbes_nohax.s3o]],
      noSelfDamage            = true,
      projectiles             = 2,
      range                   = 1450,
      reloadtime              = 30,
      smokeTrail              = false,
      soundHit                = [[weapon/missile/rapid_rocket_hit]],
      soundHitVolume          = 5,
      soundStart              = [[weapon/missile/rapid_rocket_fire]],
      soundStartVolume        = 5,
      startVelocity           = 100,
      tolerance               = 512,
      trajectoryHeight        = 1,
      turnRate                = 2500,
      turret                  = true,
      weaponAcceleration      = 100,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 250,
      wobble                  = 7000,
    },
    
    SLAM_SALVO = {
      name                    = [[S.L.A.M. Barrage (Immobilises Merlin)]],
      avoidFeature            = false,
      avoidGround             = false,
      burst                   = 20,
      areaOfEffect            = 192,
      burst                   = 20,
      burstrate               = 0.4,
      burnblow                = true,
      cegTag                  = [[slam_trail]],
      commandFire             = true,
      --craterAreaOfEffect      = 106.66667,
      craterBoost             = 800,
      craterMult              = 1.0,

      customParams            = {
        muzzleEffectFire = [[custom:SLAM_MUZZLE]],
        light_camera_height = 2500,
        light_color = [[1 0.8 0.2]],
        reaim_time = 1,
      },

      damage                  = {
        default = 600,
      },

      dance                   = 20,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:spidercrabe_EXPLOSION]],
      fireStarter             = 180,
      fixedlauncher           = true,
      flightTime              = 4,
      impulseBoost            = 0,
      impulseFactor           = 0.8,
      interceptedByShieldType = 2,
      model                   = [[wep_m_phoenix_nonhax.s3o]],
      noSelfDamage            = false,
      projectiles             = 2,
      range                   = 850,
      reloadtime              = 60,
      smokeTrail              = false,
      soundHit                = [[weapon/bomb_hit]],
      soundStart              = [[weapon/missile/missile_fire2]],
      startVelocity           = 100,
      targetBorder            = 1,
      tolerance               = 4000,
      trajectoryHeight        = 1,
      turnRate                = 2500,
      turret                  = true,
      weaponAcceleration      = 100,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 250,
      wobble                  = 7000,
    },
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[catapult_wreck.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris4x4b.s3o]],
    },

  },

} }
