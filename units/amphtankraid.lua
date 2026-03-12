return { amphtankraid = {
  name                   = [[Springald]],
  description            = [[Light Raider Amphtank]],
  acceleration           = 0.342,
  activateWhenBuilt      = true,
  brakeRate              = 0.84,
  builder                = false,
  buildPic               = [[vehraid.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[HOVER SMALL TOOFAST]],
  collisionVolumeOffsets = [[0 -5 0]],
  collisionVolumeScales  = [[26 26 36]],
  collisionVolumeType    = [[cylZ]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[42 42 51]],
  selectionVolumeType    = [[cylZ]],
  corpse                 = [[DEAD]],

  customParams           = {
    modelradius        = [[10]],
    aim_lookahead      = 80,
    set_target_range_buffer = 30,
    set_target_speed_buffer = 8,
    selection_scale = 1.2,
  },

  explodeAs              = [[BIG_UNITEX]],
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 480,
  iconType               = [[shipscout_alt]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 100,
  movementClass          = [[HOVER2]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName             = [[corgator_512.s3o]],
  script                 = [[amphtankraid.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_ORANGE_SMALL]],
    },

  },
  sightDistance          = 560,
  sonarDistance          = 560,
  speed                  = 95,
  trackOffset            = 5,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 28,
  turninplace            = 0,
  turnRate               = 1125,
  waterline              = 10,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[PARTICLEBEAM]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

weaponDefs             = {

    PARTICLEBEAM = {
      name                    = [[Particle Beam Repeater]],
      beamDecay               = 0.85,
      beamTime                = 1/30,
      beamttl                 = 45,
      beamBurst               = true,
      burst                   = 3,
      burstrate               = 0.1,
      coreThickness           = 0.5,
      craterBoost             = 0,
      craterMult              = 0,

      customParams            = {
        burst = Shared.BURST_RELIABLE,
        
        light_color = [[0.9 0.22 0.22]],
        light_radius = 80,
      },

      damage                  = {
        default = 45.01,
      },

      explosionGenerator      = [[custom:flash1red]],
      fireStarter             = 100,
      impactOnly              = true,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      laserFlareSize          = 7.5,
      minIntensity            = 1,
      range                   = 240,
      reloadtime              = 2,
      rgbColor                = [[1 0 0]],
      soundStart              = [[weapon/laser/mini_laser]],
      soundStartVolume        = 6,
      thickness               = 5,
      tolerance               = 3000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
    },

  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[gatorwreck.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
