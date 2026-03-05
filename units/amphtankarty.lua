return { amphtankarty = {
  name                = [[Arbalest]],
  description         = [[Rapidfire Gauss Firesupport]],
  acceleration        = 0.17,
  activateWhenBuilt   = true,
  brakeRate           = 1.632,
  builder             = false,
  buildPic            = [[tankarty.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[HOVER]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[63 63 63]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    unstick_leeway    = 30, -- Don't lose move orders if stuck while packing.
  },

  explodeAs           = [[BIG_UNITEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  health              = 900,
  iconType            = [[tankarty]],
  leaveTracks         = true,
  maxSlope            = 18,
  maxWaterDepth       = 22,
  metalCost           = 1200,
  movementClass       = [[HOVER3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName          = [[cormart.s3o]],
  pushResistant       = 0,
  selfDestructAs      = [[BIG_UNITEX]],
  script              = [[amphtankarty.lua]],
  sightDistance       = 660,
  sonarDistance       = 660,
  speed               = 63,
  trackOffset         = 8,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 34,
  turninplace         = 0,
  turnRate            = 512,
  waterline           = 8,   
  workerTime          = 0,

  weapons             = {

    {
      def                = [[GAUSS]],
      --mainDir            = [[0 0 1]],
--      maxAngleDif        = 180,
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    GAUSS = {
      name                    = [[Gauss Repeater]],
      accuracy                = 600,
      alphaDecay              = 0.12,
      areaOfEffect            = 16,
      avoidfeature            = false,
      bouncerebound           = 0.15,
      bounceslip              = 1,
      cegTag                  = [[gauss_tag_l]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams = {
        --burst = Shared.BURST_RELIABLE,

        --single_hit = true,
      },

      damage                  = {
        default = 50.1,
        planes  = 50.1,
      },
      
      explosionGenerator      = [[custom:gauss_hit_m]],
      groundbounce            = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noExplode               = true,
      noSelfDamage            = true,
      numbounce               = 40,
      range                   = 1000,
      reloadtime              = 0.4,
      rgbColor                = [[0.5 1 1]],
      separation              = 0.5,
      size                    = 0.8,
      soundHit                = [[weapon/gauss_hit]],
      soundHitVolume          = 3,
      soundStart              = [[weapon/gauss_fire]],
      soundStartVolume        = 2.5,
      stages                  = 32,
      turret                  = true,
      waterweapon             = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1200,
    },
  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[cormart_dead.s3o]],
    },

    
    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2a.s3o]],
    },

  },

} }
