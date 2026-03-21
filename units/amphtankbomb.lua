return { amphtankbomb = {
  name                   = [[Plaguerat]],
  description            = [[Amphibious Terrain Flattening and Nanoplague Bomb]],
  acceleration           = 0.45,
  activateWhenBuilt      = true,
  brakeRate              = 1.2,
  buildPic               = [[AMPHBOMB.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND SMALL TOOFAST]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[16 12 22]],
  collisionVolumeType    = [[box]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[45 45 45]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    midposoffset   = [[0 5 0]],
    normaltex = [[unittextures/b_can_pyro_roach_skuttle_normals.dds]],
 },

  explodeAs              = [[AMPHTANKBOMB_DEATH]],
  fireState              = 0,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 600,
  iconType               = [[amphbomb]],
  kamikaze               = true,
  kamikazeDistance       = 30,
  kamikazeUseLOS         = true,
  leaveTracks            = true,
  maxSlope               = 36,
  metalCost              = 200,
  movementClass          = [[AKBOT2]],
  noChaseCategory        = [[FIXEDWING LAND SINK TURRET SHIP SATELLITE SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName             = [[amphbomb.s3o]],
  pushResistant          = 0,
  script                 = [[amphtankbomb.lua]],
  selfDestructAs         = [[AMPHTANKBOMB_DEATH]],
  selfDestructCountdown  = 0,

  sfxtypes               = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:VINDIBACK]],
      [[custom:RIOTBALL]],
    },

  },
  sightDistance          = 240,
  sonarDistance          = 240,
  speed                  = 100,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShortLarge]],
  trackWidth             = 30,
  turnRate               = 3600,
  
  featureDefs            = {

    DEAD      = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[amphbomb_dead.s3o]],
    },

    HEAP      = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2b.s3o]],
    },

  },
  weaponDefs = {
    AMPHTANKBOMB_DEATH = {
      name               = "Nanoplague Bomb",
      areaOfEffect       = 300,
      craterBoost        = 1,
      craterMult         = 3.5,
      customparams = {
        apply_nano_plague       = "1",
        plague_rez_build_power  = 8,
        
        gatherradius = [[300]],
        smoothradius = [[200]],
        smoothmult   = [[0.7]],
        
        nofriendlyfire = 1,
      },
     
      damage = {
        default          = 120.1,
      },
     
      edgeEffectiveness  = 0.4,
      explosionGenerator = [[custom:bull_fade]],
      impulseBoost       = 1,
      impulseFactor      = 1,
      soundHit           = [[weapon/aoe_aura2]],
      soundHitVolume     = 4,
    },
  }
} 
}
