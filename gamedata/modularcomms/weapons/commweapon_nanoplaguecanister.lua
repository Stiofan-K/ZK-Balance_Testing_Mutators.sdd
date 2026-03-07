local name = "commweapon_nanoplaguecanister"
local weaponDef = {
      name                    = [[Nanoplague Canister Missile]],
      areaOfEffect            = 400,
      avoidFeature            = false,
      burnblow                = true,
      cegTag                  = [[seismictrail]],
      craterBoost             = 1,
      craterMult              = 1.4,
	  commandfire			  = true,
      
      customParams        = {
		is_unit_weapon = 1,
		slot = [[3]],
		manualfire = 1,

        apply_nano_plague       = "1",
        plague_rez_build_power  = 30,

		reaim_time = 1,
      },
      
      damage                  = {
        default = 20,
      },
      
      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:bull_fade]],
      fireStarter             = 70,
      flightTime              = 4,
      impulseBoost            = 0.75,
      impulseFactor           = 0.3,
      interceptedByShieldType = 2,
      leadlimit               = 0,
      model                   = [[wep_merl.s3o]],
      range                   = 450,
      reloadtime              = 30,
      smokeTrail              = true,
      soundHit                = [[weapon/aoe_aura2]],
      soundHitVolume          = 15,
      soundStart              = [[weapon/missile/rapid_rocket_fire2]],
      soundStartVolume        = 7,
      startVelocity           = 230,
      texture2                = [[lightsmoketrail]],
      trajectoryHeight        = 0.3,
      turnRate                = 21000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 230,
    }

return name, weaponDef
