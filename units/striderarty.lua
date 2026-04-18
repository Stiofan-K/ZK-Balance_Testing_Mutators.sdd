return { striderarty = {
  name                   = [[Merlin]],
  description            = [[Heavy Saturation Artillery Strider (Immobilises to fire)]],
  acceleration           = 0.328,
  brakeRate              = 1.165,
  builder                = false,
  buildPic               = [[striderarty.png]],
  canGuard               = true,
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
  },


  weaponDefs             = {

ROCKET = {
      name                    = [[S.L.A.M. Barrage (Immobilises Merlin)]], --Do we know what slam actually stands for? :O
      --accuracy                = 1000, Accuracy has seemingly no effect on missile weapons
      avoidFeature            = false,
      avoidGround             = false,
      burst                   = 20,
      areaOfEffect            = 192,
      burst                   = 20,
      burstrate               = 0.4,
      burnblow                = true, --Using terraform for range extention doesnt seem tooo bad here, but to be safe, burnblow is here
      cegTag                  = [[slam_trail]],
      --craterAreaOfEffect      = 106.66667,
      craterBoost             = 800,
      craterMult              = 1.0,

      customParams            = {
        muzzleEffectFire = [[custom:SLAM_MUZZLE]],
        light_camera_height = 2500,
        light_color = [[1 0.8 0.2]],
        reaim_time = 1,
        burst = Shared.BURST_UNRELIABLE,
      },

      damage                  = {
        default = 400,
      },

      dance                   = 20,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:spidercrabe_EXPLOSION]],
      fireStarter             = 180,
      fixedlauncher           = true,
      flightTime              = 8,
      impulseBoost            = 0,
      impulseFactor           = 0.8,
      interceptedByShieldType = 2,
      model                   = [[wep_b_paveway.s3o]], -- was hobbes_nohax.s3o but that felt a little tame for the explosion.
      noSelfDamage            = true,
      projectiles             = 2,
      range                   = 1100,
      reloadtime              = 60,
      smokeTrail              = false,
      soundHit                = [[weapon/bomb_hit]],
      soundStart              = [[weapon/missile/missile_fire2]],
      startVelocity           = 100,
      --sprayAngle              = 9000, also doesnt really do anything/actively burning missiles correct themselves
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
