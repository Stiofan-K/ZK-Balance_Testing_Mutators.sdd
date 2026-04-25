return { nebula = {
  name                   = [[Nebula]],
  description            = [[Atmospheric Mothership]],
  acceleration           = 0.03,
  activateWhenBuilt      = true,
  airStrafe              = 0,
  bankingAllowed         = false,
  brakeRate              = 0.48,
  builder                = false,
  buildPic               = [[nebula.png]],
  canFly                 = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canSubmerge            = false,
  category               = [[GUNSHIP]],
  collide                = true,
  collisionVolumeOffsets = [[0 00 0]],
  collisionVolumeScales  = [[40 50 220]],
  collisionVolumeType    = [[box]],

  corpse                 = [[DEAD]],
  cruiseAltitude         = 300,

  customParams           = {
    cantuseairpads = 1,
    modelradius    = [[40]],
    shield_emit_height = 20,

    outline_x = 420,
    outline_y = 420,
    outline_yoff = 40,
  },

  explodeAs              = [[ESTOR_BUILDING]],
  floater                = true,
  footprintX             = 5,
  footprintZ             = 5,
  health                 = 10000,
  hoverAttack            = true,
  iconType               = [[nebula]],
  metalCost              = 4500,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName             = [[nebula.s3o]],
  script                 = [[nebula.lua]],
  selfDestructAs         = [[ESTOR_BUILDING]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:brawlermuzzle]],
      [[custom:plasma_hit_96]],
      [[custom:EXP_MEDIUM_BUILDING_SMALL]],
    },

  },
  sightDistance          = 1000,
  speed                  = 55,
  turnRate               = 100,
  upright                = true,
  workerTime             = 0,
  
  weapons                = {
    {
      def                = [[CANNON]],
      mainDir            = [[0 1 -1]], -- top
      maxAngleDif        = 250,
      badTargetCategory  = [[MOBILE]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
    {
      def                = [[CANNON]],
      mainDir            = [[0 -1 0]], -- bottom
      maxAngleDif        = 210,
      badTargetCategory  = [[MOBILE]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
    {
      def                = [[CANNON]],
      mainDir            = [[-1 0 0]], -- left
      maxAngleDif        = 210,
      badTargetCategory  = [[MOBILE]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
    {
      def                = [[CANNON]],
      mainDir            = [[1 0 0]], -- right
      maxAngleDif        = 210,
      badTargetCategory  = [[MOBILE]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs             = {

    CANNON = {
      name                    = [[Kinetic Driver]],
      accuracy                = 100,
      alphaDecay              = 0.1,
      areaOfEffect            = 32,
      burst                   = 4,
      burstrate               = 0.3,
      colormap                = [[1 0.95 0.4 1   1 0.95 0.4 1    0 0 0 0.01    1 0.7 0.2 1]],
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 100,
      },

      explosionGenerator      = [[custom:plasma_hit_32]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      noGap                   = false,
      noSelfDamage            = true,
      range                   = 800,
      reloadtime              = 4,
      rgbColor                = [[1 0.95 0.4]],
      separation              = 2,
      size                    = 2.5,
      sizeDecay               = 0,
      soundStart              = [[weapon/cannon/cannon_fire8]],
      soundHit                = [[explosion/ex_small14]],
      sprayAngle              = 360,
      stages                  = 12,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
    },
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      collisionVolumeOffsets = [[0 0 0]],
      collisionVolumeScales  = [[40 50 220]],
      collisionVolumeType    = [[box]],
      featureDead      = [[HEAP]],
      footprintX       = 5,
      footprintZ       = 5,
      object           = [[nebula_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris4x4a.s3o]],
    },

  },

} }
