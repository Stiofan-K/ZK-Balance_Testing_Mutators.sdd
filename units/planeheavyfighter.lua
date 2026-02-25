return { planeheavyfighter = {
  name                   = [[Raptor]],
  description            = [[Air Superiority Fighter]],
  brakerate              = 0.4,
  buildPic               = [[planeheavyfighter.png]],
  canFly                 = true,
  canGuard               = true,
  canLoopbackAttack      = true,
  canMove                = true,
  canPatrol              = true,
  canSubmerge            = false,
  category               = [[FIXEDWING]],
  collide                = false,
  collisionVolumeOffsets = [[0 0 5]],
  collisionVolumeScales  = [[38 15 64]],
  collisionVolumeType    = [[ellipsoid]],
  selectionVolumeOffsets = [[0 0 10]],
  selectionVolumeScales  = [[81 81 108]],
  selectionVolumeType    = [[cylZ]],
  corpse                 = [[DEAD]],
  crashDrag              = 0.01,
  cruiseAltitude         = 220,

  customParams           = {
    bait_level_default = 0,
    bait_level_target      = 3,

    midposoffset   = [[0 3 0]],
    aimposoffset   = [[0 3 0]],
    modelradius    = [[10]],
    refuelturnradius = [[120]],

    combat_slowdown = 0.35,
    selection_scale = 1.4,

    outline_x = 120,
    outline_y = 120,
    outline_yoff = 20,
  },

  explodeAs              = [[GUNSHIPEX]],
  fireState              = 2,
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  frontToSpeed           = 0.1,
  health                 = 2400,  --Raptor hp scaled to swifts new hp, it should keep the balance somewhat
  iconType               = [[stealthfighter]],
  maxAcc                 = 0.605,
  maxAileron             = 0.02,
  maxElevator            = 0.015,
  maxRudder              = 0.008,
  metalCost              = 300,
  mygravity              = 1,
  noChaseCategory        = [[TERRAFORM LAND SINK TURRET SHIP SWIM FLOAT SUB HOVER]],
  objectName             = [[fighter2.s3o]],
  script                 = [[planeheavyfighter.lua]],
  selfDestructAs         = [[GUNSHIPEX]],
  sightDistance          = 750,
  speed                  = 228,
  speedToFront           = 0.5,
  turnRadius             = 10,

  weapons                = {

    {
      def                = [[FLAK]],
      badTargetCategory  = [[GUNSHIP]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 70,
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs             = {

    FLAK = {
      name                    = [[Flak Cannons]],
      accuracy                = 500,
      areaOfEffect            = 128,
      voidFriendly            = false,
      burnblow                = true,
      canattackground         = false,
      cegTag                  = [[flak_trail]],
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,
      cylinderTargeting       = 1,

      customParams              = {
        isaa = [[1]],
        light_radius = 0,
      },

      damage                  = {
        default = 3.0,
        planes  = 30,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:flakplosion]],
      impulseBoost            = 0,
      impulseFactor           = 0,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 800,
      reloadtime              = 0.3,
      size                    = 0.01,
      soundHit                = [[weapon/flak_hit]],
      soundStart              = [[weapon/flak_fire]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 2000,
    },

  },


  featureDefs            = {

    DEAD = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      collisionVolumeOffsets = [[0 0 5]],
      collisionVolumeScales  = [[35 15 45]],
      collisionVolumeType    = [[box]],
      object           = [[fighter2_dead.s3o]],
    },


    HEAP = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2b.s3o]],
    },

  },

} }
