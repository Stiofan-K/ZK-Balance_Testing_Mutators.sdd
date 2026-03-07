local name = "commweapon_nanoplaguedart"
local weaponDef = {
      name                    = [[Nanoplague Dart]],
      areaOfEffect            = 80,
      avoidFeature            = false,
      burnblow                = true,
      cegTag                  = [[seismictrail]],
      commandfire             = true,
      craterBoost             = 1,
      craterMult              = 1.4,
      
      customParams        = {
		is_unit_weapon = 1,
		slot = [[3]],
		manualfire = 1,

        apply_nano_plague       = "1",
        plague_rez_build_power  = 80,

		reaim_time = 1,
      },
      
      damage                  = {
        default = 20,
      },
      
      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:greencannonimpact]],
      fireStarter             = 70,
      flightTime              = 1,
      impulseBoost            = 0.75,
      impulseFactor           = 0.3,
      interceptedByShieldType = 2,
      leadlimit               = 0,
      model                   = [[wep_t_barracuda.s3o]],
      range                   = 500,
      reloadtime              = 30,
      smokeTrail              = true,
      soundHit                = [[weapon/aoe_aura2]],
      soundHitVolume          = 15,
      soundStart              = [[weapon/gauss_fire]],
      soundStartVolume        = 7,
      startVelocity           = 1000,
      texture2                = [[lightsmoketrail]],
      trajectoryHeight        = 0.1,
      turnRate                = 21000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 1000,
    }

return name, weaponDef
