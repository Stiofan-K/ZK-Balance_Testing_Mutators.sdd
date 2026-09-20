return { amphtanksubassault = {
  name                = [[Crocodile]],
  description         = [[Subsurface Assault Bombard]],
  acceleration        = 0.17,
  activateWhenBuilt   = true,
  brakeRate           = 0.624,
  builder             = false,
  buildPic            = [[tankheavyassault.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND SINK]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[96 96 96]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    bait_level_default = 1,
    decloak_footprint     = 5,

    outline_x = 110,
    outline_y = 110,
    outline_yoff = 13.5,
  },

  explodeAs           = [[BIG_UNIT]],
  floater             = true,
  footprintX          = 4,
  footprintZ          = 4,
  health              = 6200,
  iconType            = [[shipassault_alt]],
  leaveTracks         = true,
  maxSlope            = 18,
  maxWaterDepth       = 22,
  metalCost           = 750,
  movementClass       = [[HOVER4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[corgol_512.s3o]],
  script              = [[amphtanksubassault.lua]],
  selfDestructAs      = [[BIG_UNIT]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:LARGE_MUZZLE_FLASH_FX]],
    },

  },
  sightDistance       = 380,
  sonarDistance       = 380,
  speed               = 57,
  trackOffset         = 8,
  trackStrength       = 10,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 50,
  turninplace         = 0,
  turnRate            = 450,
  waterline           = 60,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[SLAM_ROCKET]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND TURRET FLOAT SHIP HOVER GUNSHIP]],
    },
    {
      def                = [[SLAM_VLS]],
      badTargetCategory  = [[FIXEDWING GUNSHIP SUB SINK]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs          = {

    SLAM_ROCKET = {
      name                    = [[S.L.A.M. TLS]],
      avoidFeature            = false,
      --avoidGround             = false,
      areaOfEffect            = 140,
      burnblow                = true,
      cegTag                  = [[slam_trail]],
      --craterAreaOfEffect      = 106.66667,
      craterBoost             = 800,
      craterMult              = 1.0,

      customParams            = {
        muzzleEffectFire = [[custom:SLAM_MUZZLE]],
        light_camera_height = 2500,
        light_color = [[1 0.8 0.2]],
        reaim_time = 1,
        gatherradius = [[105]],
        smoothradius = [[70]],
        smoothmult   = [[0.4]],
        
      },

      damage                  = {
        default = 1050.01, -- 1000 damage vs 1100 affects a good few breakpoints. unsure which is better
      },

      edgeEffectiveness       = 0.4,
      explosionGenerator      = [[custom:slam]],
      fireStarter             = 180,
      fixedlauncher           = true,
      flightTime              = 3,
      impulseBoost            = 0.2,
      impulseFactor           = 1,
      interceptedByShieldType = 2,
      model                   = [[wep_m_phoenix_nonhax.s3o]],
      range                   = 380,
      reloadtime              = 10,
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
    },
    SLAM_VLS = {
      name                    = [[S.L.A.M. VLS]],
      avoidFeature            = false,
      --avoidGround             = false,
      areaOfEffect            = 140,
      burnblow                = true,
      cegTag                  = [[slam_trail]],
      --craterAreaOfEffect      = 106.66667,
      craterBoost             = 800,
      craterMult              = 1.0,

      customParams            = {
        muzzleEffectFire = [[custom:SLAM_MUZZLE]],
        light_camera_height = 2500,
        light_color = [[1 0.8 0.2]],
        reaim_time = 1,
        gatherradius = [[105]],
        smoothradius = [[70]],
        smoothmult   = [[0.4]],
        water_surface_explode = true,
      },

      damage                  = {
        default = 1050.01, -- 1000 damage vs 1100 affects a good few breakpoints. unsure which is better
      },

      edgeEffectiveness       = 0.4,
      explosionGenerator      = [[custom:slam]],
      fireStarter             = 180,
      fixedlauncher           = true,
      flightTime              = 15,
      impulseBoost            = 0.2,
      impulseFactor           = 1,
      interceptedByShieldType = 2,
      model                   = [[wep_m_phoenix_nonhax.s3o]],
      range                   = 380,
      reloadtime              = 10,
      smokeTrail              = false,
      soundHit                = [[weapon/bomb_hit]],
      soundStart              = [[weapon/missile/missile_fire2]],
      startVelocity           = 100,
      targetBorder            = 1,
      tolerance               = 4000,
      trajectoryHeight        = 1,
      turnRate                = 10000,
      turret                  = true,
      waterWeapon             = true, -- I think the assumption is that fully submerged units shouldnt be able to use non water weapons so this needs to be enabled bleh. will explode it on surface via gadget
      weaponAcceleration      = 100,
      weaponTimer             = 0.5,
      weaponType              = [[StarburstLauncher]],
      weaponVelocity          = 250,
    },
  },


  featureDefs         = {

    DEAD       = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[golly_d.s3o]],
    },

    
    HEAP       = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris4x4c.s3o]],
    },

  },

} }
