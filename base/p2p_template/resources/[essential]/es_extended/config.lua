Config                      = {}
Config.Locale               = GetConvar('esx:locale', 'fr')

Config.Accounts             = {
	bank = {
		label = TranslateCap('account_bank'),
		round = true
	},
	black_money = {
		label = TranslateCap('account_black_money'),
		round = true
	},
	money = {
		label = TranslateCap('account_money'),
		round = true
	}
}

Config.StartingAccountMoney = { bank = 50000 }

Config.StartingInventoryItems = false -- table/false

Config.DefaultSpawns = { -- If you want to have more spawn positions and select them randomly uncomment commented code or add more locations
	{ x = 222.2027, y = -864.0162, z = 30.2922, heading = 1.0 },
	--{x = 224.9865, y = -865.0871, z = 30.2922, heading = 1.0},
	--{x = 227.8436, y = -866.0400, z = 30.2922, heading = 1.0},
	--{x = 230.6051, y = -867.1450, z = 30.2922, heading = 1.0},
	--{x = 233.5459, y = -868.2626, z = 30.2922, heading = 1.0}
}

Config.AdminGroups = {
	['owner'] = true,
	['admin'] = true
}


Config.EnablePaycheck            = true      -- enable paycheck
Config.LogPaycheck               = true     -- Logs paychecks to a nominated Discord channel via webhook (default is false)
Config.EnableSocietyPayouts      = false     -- pay from the society account that the player is employed at? Requirement: esx_society
Config.MaxWeight                 = 24        -- the max inventory weight without backpack
Config.PaycheckInterval          = 7 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug               = false     -- Use Debug options?
Config.EnableDefaultInventory    = true      -- Display the default Inventory ( F2 )
Config.EnableWantedLevel         = false     -- Use Normal GTA wanted Level?
Config.EnablePVP                 = true      -- Allow Player to player combat

Config.Multichar                 = GetResourceState("esx_multicharacter") ~= "missing"
Config.Identity                  = true  -- Select a characters identity data before they have loaded in (this happens by default with multichar)
Config.DistanceGive              = 4.0   -- Max distance when giving items, weapons etc.

Config.AdminLogging              = true -- Logs the usage of certain commands by those with group.admin ace permissions (default is false)

Config.DisableHealthRegeneration = true -- Player will no longer regenerate health
Config.DisableVehicleRewards     = true -- Disables Player Recieving weapons from vehicles
Config.DisableNPCDrops           = true -- stops NPCs from dropping weapons on death
Config.DisableDispatchServices   = true -- Disable Dispatch services
Config.DisableScenarios          = true -- Disable Scenarios
Config.DisableWeaponWheel        = true -- Disables default weapon wheel
Config.DisableAimAssist          = true -- disables AIM assist (mainly on controllers)
Config.DisableVehicleSeatShuff   = true -- Disables vehicle seat shuff
Config.DisableDisplayAmmo  		 = true -- Disable ammunition display

Config.RemoveHudComponents       = {
	[1] = false,                         --WANTED_STARS,
	[2] = false,                         --WEAPON_ICON
	[3] = false,                         --CASH
	[4] = false,                         --MP_CASH
	[5] = false,                         --MP_MESSAGE
	[6] = false,                         --VEHICLE_NAME
	[7] = false,                         -- AREA_NAME
	[8] = false,                         -- VEHICLE_CLASS
	[9] = false,                         --STREET_NAME
	[10] = false,                        --HELP_TEXT
	[11] = false,                        --FLOATING_HELP_TEXT_1
	[12] = false,                        --FLOATING_HELP_TEXT_2
	[13] = false,                        --CASH_CHANGE
	[14] = false,                        --RETICLE
	[15] = false,                        --SUBTITLE_TEXT
	[16] = false,                        --RADIO_STATIONS
	[17] = false,                        --SAVING_GAME,
	[18] = false,                        --GAME_STREAM
	[19] = false,                        --WEAPON_WHEEL
	[20] = false,                        --WEAPON_WHEEL_STATS
	[21] = false,                        --HUD_COMPONENTS
	[22] = false,                        --HUD_WEAPONS
}

Config.SpawnVehMaxUpgrades       = true       -- admin vehicles spawn with max vehcle settings
Config.CustomAIPlates            = '........' -- Custom plates for AI vehicles
-- Pattern string format
--1 will lead to a random number from 0-9.
--A will lead to a random letter from A-Z.
-- . will lead to a random letter or number, with 50% probability of being either.
--^1 will lead to a literal 1 being emitted.
--^A will lead to a literal A being emitted.
--Any other character will lead to said character being emitted.
-- A string shorter than 8 characters will be padded on the right.

Config.PickupsList = {
    ['eau'] = {name = "prop_ld_flow_bottle", var = false},
    ['pain'] = {name = "v_ret_247_bread1", var = false},
    ['burger'] = {name = "ng_proc_food_bag01a", var = false},
    ['wine'] = {name = "apa_mp_h_acc_bottle_01", var = false},
    ['tequila'] = {name = "apa_mp_h_acc_bottle_02", var = false},
    ['medkit'] = {name = "ex_office_swag_med2", var = false},
    ['bijou'] = {name = "prop_jewel_02b", var = false},

    ['w_at_pi_supp_2'] = {name = "w_at_scope_macro", var = false},
    ['torche'] = {name = "w_at_pi_flsh_luxe", var = false},
    ['scope'] = {name = "w_at_scope_macro", var = false},
    ['scope2'] = {name = "w_at_scope_large", var = false},
    ['jerrycan'] = {name = "w_am_jerrycan", var = false},
    ['extincteur'] = {name = "w_am_fire_exting", var = false},
    ['lait'] = {name = "v_res_tt_milk", var = false},
	['vodka'] = {name = "prop_vodka_bottle", var = false},
    ['box_.45ACP'] = {name = "prop_box_ammo02a", var = false},
	['box_12mm'] = {name = "prop_box_ammo02a", var = false},
	['box_357Magnum'] = {name = "prop_box_ammo02a", var = false},
	['box_7.62mm'] = {name = "prop_box_ammo02a", var = false},
	['box_9mm'] = {name = "prop_box_ammo02a", var = false},
    ['coca'] = {name = "ng_proc_sodabot_01a", var = false},
    ['cocacola'] = {name = "ng_proc_sodabot_01a", var = false},
    ['fanta'] = {name = "ng_proc_sodabot_01a", var = false},
    ['icetea'] = {name = "ng_proc_sodabot_01a", var = false},
    ['soda'] = {name = "ng_proc_sodabot_01a", var = false},
	['sprite'] = {name = "ng_proc_sodabot_01a", var = false},
	['caprisun'] = {name = "ng_proc_sodacan_01a", var = false},
    ['drpepper'] = {name = "ng_proc_sodacan_01a", var = false},
    ['energy'] = {name = "ng_proc_sodacan_01b", var = false},
    ['jusfruit'] = {name = "ng_proc_sodacan_01b", var = false},
    ['jus_raisin'] = {name = "ng_proc_sodacan_01b", var = false},
    ['limonade'] = {name = "ng_proc_sodacan_01b", var = false},
	['oasis'] = {name = "ng_proc_sodacup_01b", var = false},
	['redbull'] = {name = "ng_proc_sodacup_01c", var = false},
    ['coke'] = {name = "bkr_prop_coke_cut_02", var = false},
    ['coke_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
    ['fauxbillets'] = {name = "bkr_prop_bkr_cashpile_01", var = false},
    ['fauxbillets_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
    ['lsd'] = {name = "bkr_prop_weed_bigbag_01a", var = false},
    ['lsd_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
    ['meth'] = {name = "bkr_prop_meth_acetone", var = false},
	['meth_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
    ['opium'] = {name = "bkr_prop_weed_bigbag_01a", var = false},
	['opium_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
	['weed'] = {name = "bkr_prop_weed_dry_02b", var = false},
	['weed_pooch'] = {name = "bkr_prop_weed_bag_pile_01a", var = false},
	['bandage'] = {name = "p_cs_duffel_01_s", var = false},
    ['medikit'] = {name = "p_cs_duffel_01_s", var = false},
    ['bolcacahuetes'] = {name = "p_cs_bowl_01b_s", var = false},
    ['bolchips'] = {name = "p_cs_bowl_01b_s", var = false},
    ['bolnoixcajou'] = {name = "p_cs_bowl_01b_s", var = false},
    ['bolpistache'] = {name = "p_cs_bowl_01b_s", var = false},
	['tel'] = {name = "p_cs_cam_phone", var = false},
	['frites'] = {name = "prop_food_bs_chips", var = false},
    ['burger'] = {name = "prop_food_bs_burg3", var = false},
    ['hamburger'] = {name = "prop_food_bs_burg3", var = false},
    ['cafe'] = {name = "ng_proc_coffee_01a", var = false},
    ['malboro'] = {name = "ng_proc_cigpak01b", var = false},
    ['chips'] = {name = "ng_proc_food_chips01b", var = false},
    ['sachetketchup'] = {name = "prop_food_ketchup", var = false},
	['caisseketchup'] = {name = "prop_food_ketchup", var = false},
	['packaged_chicken'] = {name = "prop_food_cb_nugets", var = false},
    ['biere'] = {name = "prop_beerdusche", var = false},
    ['grand_cru'] = {name = "lux_p_champ_flute_s", var = false},
    ['vine'] = {name = "lux_p_champ_flute_s", var = false},
	['jager'] = {name = "prop_beer_blr", var = false},
    ['jagerbomb'] = {name = "prop_beer_blr", var = false},
    ['jagercerbere'] = {name = "prop_beer_blr", var = false},
    ['mixapero'] = {name = "p_cs_bowl_01b_s", var = false},
    ['mojito'] = {name = "prop_beer_logger", var = false},
    ['myrtealcool'] = {name = "prop_beer_am", var = false},
    ['pizza'] = {name = "prop_pizza_box_02", var = false},
	['hacking_laptop'] = {name = "p_laptop_02_s", var = false},
	['martini'] = {name = "prop_beer_logger", var = false},
    ['metreshooter'] = {name = "prop_beer_logger", var = false},
    ['rhum'] = {name = "lts_prop_tumbler_01_s2", var = false},
    ['rhumcoca'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['rhumfruit'] = {name = "lts_prop_tumbler_01_s2", var = false},
    ['saucisson'] = {name = "prop_food_cb_burg01", var = false},
    ['donuts'] = {name = "prop_food_cb_donuts", var = false},
	['teqpaf'] = {name = "prop_beer_blr", var = false},
	['tequila'] = {name = "prop_beer_blr", var = false},
	['vodka'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['vodkaenergy'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['vodkafruit'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['vodkrb'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['whisky'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['whiskycoc'] = {name = "lts_prop_tumbler_01_s2", var = false},
	['whiskycoca'] = {name = "lts_prop_tumbler_01_s2", var = false},



    ['lingot'] = {name = "hei_prop_heist_gold_bar", var = true, variations = {
        [1] = {varName = "hei_prop_heist_gold_bar", count = 1, count2 = 9},
        [2] = {varName = "prop_ld_gold_chest", count = 10, count2 = 10000}
    }},
}