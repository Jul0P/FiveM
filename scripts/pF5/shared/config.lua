pF5 = {
    Title = "Menu Personnel", -- titre du menu
	ESX = "new", -- new : nouvelle version d'es_extended (avec la ligne export) / old : ancienne version d'es_extended (sans la ligne export)
	Legacy = true, -- mettez false si vous n'êtes pas sous legacy
	MaxLineInMenu = 15, -- nombre maximum de ligne visible dans le menu
	MenuX = 1450, -- Position X du menu
	Weapon = {
		Active = true -- true si vous souhaitez activer la catégorie arme dans l'inventaire
	},
	pClothes = {
		Active = false, -- true si vous souhaitez activer un bouton vous menant à la gestion vêtements & accessoires
		FilterInventory = false -- true si vous souhaitez activer la catégorie vêtements & accessoires dans l'inventaire, il faut que le Active soit sur true aussi
	},
	pSim = {
		Active = false,  -- true si vous souhaitez activer un bouton vous menant à la gestion carte sim
		FilterInventory = false, -- true si vous souhaitez activer la catégorie carte sim dans l'inventaire, il faut que le Active soit sur true aussi
		NamePhoneItem = "phone"
	},
	Weight = false, -- true si vous avez le système de poid de base avec votre es_extended
	LocalWeight = { 
		Active = true, -- [ATTENTION] : Activer le LocalWeight que si le Weight est sur false en gros que si vous n'avez pas le système de poid dans votre es_extended
		maxWeight = 50,
		weight = {
			bread = 1,
			water = 2,
		}
	},
    Key = "F5", -- touche d'ouverture du menu -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	KeyPointing = "B", -- touche pointer du doigt -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	KeyHandsup = "N", -- touche lever les mains  -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	KeyCrouched = "LCONTROL", -- touche pour s'accroupir -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	KeyRagdoll = "COMMA", -- touche pour dormir / se réveiller -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	VehicleCallPrice = 250, -- prix de l'appel d'un véhicule
	Active = {
		CommandPorter = true, -- true si vous souhaitez que la commande /porter soit activé
		CommandCarry = true, -- true si vous souhaitez que la commande /carry soit activé
		CommandOtage = true, -- true si vous souhaitez que la commande /otage soit activé

		KeyRagdoll = true, -- true si vous souhaitez que la touche pour dormir / se réveiller soit
		KeyPointing = true, -- true si vous souhaitez que l'animation pointer du doigt soit activé
		KeyHandsup = true, -- true si vous souhaitez que l'animation lever les mains soit activé
		KeyCrouched = true, -- true si vous souhaitez que l'animation s'accroupir soit activé

		ButtonPorter = true, -- true si vous souhaitez que le button pour porter soit activé
		ButtonCarry = true, -- true si vous souhaitez que le button pour carry soit activé
		ButtonOtage = true, -- true si vous souhaitez que le button pour prendre en otage soit activé
		ButtonRagdoll = true, -- true si vous souhaitez que le button pour dormir / se réveiller soit activé

		VehicleCall = true, -- true si vous souhaitez que le button pour appeler un véhicule soit activé
		WeaponAnimation = true, -- true si vous souhaitez que le button pour modifier ses animations d'armes soit activé
		VisualEffect = true, -- true si vous souhaitez que le button pour changer les effets viseuls soit activé
		Cinematique = true, -- true si vous souhaitez que le button pour avoir un mode cinématique soit activé	 
		
		Inventaire = true, -- true si vous souhaitez que le button pour accéder à l'inventaire soit activé
		Portefeuille = true, -- true si vous souhaitez que le button pour accéder au portefeuille soit activé
		Facture = true, -- true si vous souhaitez que le button pour accéder au menu facture soit activé
		VetementsAccessoires = true, -- true si vous souhaitez que le button pour accéder au menu vêtements et accessoires soit activé
		Pub = true, -- true si vous souhaitez que le button pour accéder au menu pub soit activé
		Props = true, -- true si vous souhaitez que le button pour accéder au menu props soit activé
		Divers = true, -- true si vous souhaitez que le button pour accéder au menu divers soit activé
		GestionCles = true, -- true si vous souhaitez que le button pour accéder au menu gestion clés soit activé
		GestionVehicule = true, -- true si vous souhaitez que le button pour accéder au menu gestion véhicule soit activé
		GestionSociete = true, -- true si vous souhaitez que le button pour accéder au menu gestion société soit activé

		PubJob = true, -- true si vous souhaitez que le button pour faire une publicité job soit activé
		PubTwitter = true, -- true si vous souhaitez que le button pour faire une publicité twitter soit activé
		PubTwitterAno = true, -- true si vous souhaitez que le button pour faire une publicité twitter en ano soit activé
	},
	JobAuthorized = {
		"police",
		"ambulance",
	},
	Clothes = {
		Male = {
			torso_1 = 15,
			torso_2 = 0,
			tshirt_1 = 15,
			tshirt_2 = 0,
			arms = 15,
			pants_1 = 18,
			pants_2 = 0,
			shoes_1 = 34,
			shoes_2 = 0,
			bags_1 = 0,
			bags_2 = 0,
			bproof_1 = 0,
			bproof_2 = 0,
			glasses_1 = 0,
			glasses_2 = 0,
			ears_1 = -1,
			ears_2 = 0,
			helmet_1 = -1,
			helmet_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
			mask_1 = 0,
			mask_2 = 0,
			watches_1 = 0,
			watches_2 = 0,
			bracelets_1 = 0,
			bracelets_2 = 0
		},
		Female = {
			torso_1 = 15,
			torso_2 = 0,
			tshirt_1 = 15,
			tshirt_2 = 0,
			arms = 15,
			pants_1 = 15,
			pants_2 = 0,
			shoes_1 = 35,
			shoes_2 = 0,
			bags_1 = 0,
			bags_2 = 0,
			bproof_1 = 0,
			bproof_2 = 0,
			glasses_1 = 5,
			glasses_2 = 0,
			ears_1 = -1,
			ears_2 = 0,
			helmet_1 = -1,
			helmet_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
			mask_1 = 0,
			mask_2 = 0,
			watches_1 = 0,
			watches_2 = 0,
			bracelets_1 = 0,
			bracelets_2 = 0
		}
	},
    Civil = {
		{model = "apa_mp_h_din_chair_12", name = "Chaise"},
		{model = "prop_cardbordbox_04a", name = "Carton"},
		{model = "prop_cs_heist_bag_02", name = "Sac"},
		{model = "prop_rub_table_02", name = "Table 1"},
		{model = "prop_table_04", name = "Table 2"},
		{model = "bkr_prop_weed_table_01b", name = "Table 3"},
		{model = "prop_bench_06", name = "Banc 1"},
		{model = "prop_bench_04", name = "Banc 2"},
		{model = "prop_bench_08", name = "Banc 3"},
		{model = "prop_bench_01a", name = "Banc 4"},
		{model = "prop_bench_10", name = "Banc 5"},
		{model = "prop_bench_11", name = "Banc 6"},
		{model = "bkr_prop_clubhouse_chair_01", name = "Petite Chaise"},
		{model = "bkr_prop_clubhouse_laptop_01a", name = "Ordinateur"},
		{model = "prop_tv_flat_01", name = "Télévision"},
		{model = "bkr_prop_clubhouse_offchair_01a", name = "Chaise Bureau"},
		{model = "gr_prop_bunker_bed_01", name = "Lit Bunker"},
		{model = "gr_prop_gr_campbed_01", name = "Lit Biker"},
		{model = "hei_prop_hei_skid_chair", name = "Chaise Peche"},
		{model = "apa_prop_flag_france", name = "Drapeau France"},
	},
	LSPD = {
		{model = "prop_roadcone02a", name = "Cone"},
		{model = "prop_barrier_work05", name = "Barrière"},
		{model = "prop_boxpile_07d", name = "Gros carton"},
		{model = "p_ld_stinger_s", name = "Herse"},
	},
	EMS = {
		{model = "xm_prop_body_bag", name = "Sac mortuaire"},
		{model = "xm_prop_smug_crate_s_medical", name = "Trousse médical 1"},
		{model = "xm_prop_x17_bag_med_01a", name = "Trousse médical 2"},
	},
	Mecano = {
		{model = "prop_cs_trolley_01", name = "Outils"},
		{model = "prop_carcreeper", name = "Outils mecano"},
		{model = "prop_cs_heist_bag_02", name = "Sac à outils"},
	},
	Gang = {
		{model = "bkr_prop_weed_chair_01a", name = "Chaise"},
		{model = "prop_gun_case_01", name = "Sac d'arme"},
		{model = "hei_prop_cash_crate_half_full", name = "Argent"},
		{model = "prop_cash_case_02", name = "Valise d'argent"},
		{model = "prop_cs_dumpster_01a", name = "Poubelle"},
		{model = "v_tre_sofa_mess_c_s", name = "Canapé"},
		{model = "v_res_tre_sofa_mess_a", name = "Canapé 2"},
		{model = "prop_cash_crate_01", name = "Pile d'argent"},
		{model = "bkr_prop_bkr_cashpile_04", name = "Pile d'argent 2"},
		{model = "bkr_prop_bkr_cashpile_05", name = "Pile d'argent 3"},
	},
	Armes = {
		{model = "bkr_prop_biker_gcase_s", name = "Malette d'Armes"},
		{model = "ex_office_swag_guns04", name = "Caisse Batteuses"},
		{model = "ex_prop_crate_ammo_sc", name = "Caisse Batteuses 2"},
		{model = "ex_prop_crate_ammo_bc", name = "Caisse Armes"},
		{model = "ex_prop_adv_case_sm_03", name = "Caisse Fermé"},
		{model = "ex_prop_adv_case_sm_flash", name = "Petite Caisse"},
		{model = "ex_prop_crate_expl_bc", name = "Caisse Explosif"},
		{model = "ex_prop_crate_expl_sc", name = "Caisse Vetements"},
		{model = "gr_prop_gr_crate_mag_01a", name = "Caisse Chargeurs"},
		{model = "gr_prop_gr_crates_rifles_01a", name = "Grosse Caisse Armes"},
		{model = "gr_prop_gr_crates_weapon_mix_01a", name = "Grosse Caisse Armes 2"},
	},
	Drogue = {
		{model = "bkr_prop_coke_block_01a", name = "Block de cocaïne"},
		{model = "bkr_prop_coke_pallet_01a", name = "Pallet de cocaïne"},
		{model = "bkr_prop_coke_scale_01", name = "Balance de cocaïne"},
		{model = "bkr_prop_coke_spatula_04", name = "Spatule de cocaïne"},
		{model = "bkr_prop_coke_table01a", name = "Table de cocaïne"},
		{model = "bkr_prop_crate_set_01a", name = "Caisse"},
		{model = "bkr_prop_fertiliser_pallet_01a", name = "Palette de Weed"},
		{model = "bkr_prop_fertiliser_pallet_01b", name = "Palette"},
		{model = "bkr_prop_fertiliser_pallet_01c", name = "Palette 2"},
		{model = "bkr_prop_fertiliser_pallet_01d", name = "Palette 3"},
		{model = "bkr_prop_meth_acetone", name = "Acetone Meth"},
		{model = "bkr_prop_meth_ammonia", name = "Bidon de Meth"},
		{model = "bkr_prop_meth_bigbag_01a", name = "Bac de Meth"},
		{model = "bkr_prop_meth_bigbag_02a", name = "Bac de Meth 2"},
		{model = "bkr_prop_meth_bigbag_03a", name = "Bac de Meth 3"},
		{model = "bkr_prop_meth_lithium", name = "Lithium Meth"},
		{model = "bkr_prop_meth_phosphorus", name = "Phosphorus Meth"},
		{model = "bkr_prop_meth_pseudoephedrine", name = "Pseudoephedrine"},
		{model = "bkr_prop_meth_smashedtray_01", name = "Meth Smash"},
		{model = "bkr_prop_money_counter", name = "Machine à sous"},
		{model = "bkr_prop_meth_acetone", name = "Acetone Meth"},
		{model = "bkr_prop_weed_01_small_01b", name = "Pot de Weed"},
		{model = "bkr_prop_weed_bucket_01d", name = "Pot de Weed 2"},
		{model = "bkr_prop_weed_bigbag_03a", name = "Packet de Weed"},
		{model = "bkr_prop_weed_bigbag_open_01a", name = "Packet de Weed Ouvert"},
		{model = "bkr_prop_weed_drying_01a", name = "Weed"},
		{model = "bkr_prop_weed_lrg_01b", name = "Plante de Weed"},
		{model = "bkr_prop_weed_med_01b", name = "Plante de Weed 2"},
		{model = "bkr_prop_weed_drying_01a", name = "Table de Weed"},
		{model = "hei_prop_heist_weed_pallet", name = "Pallet de Weed"},
		{model = "imp_prop_impexp_boxcoke_01", name = "Coke"},
		{model = "bkr_prop_coke_bottle_01a", name = "Coke en Bouteille"},
		{model = "bkr_prop_coke_cut_01", name = "Coke Coupé"},
		{model = "bkr_prop_coke_fullmetalbowl_02", name = "Bol de Coke"},
		{model = "bkr_prop_meth_pseudoephedrine", name = "Prop de Meth"},
		{model = "bkr_prop_meth_openbag_01a", name = "Sac de Meth Ouvert"},
		{model = "bkr_prop_meth_bigbag_04a", name = "Gros Sac de Meth"},
		{model = "bkr_prop_weed_bigbag_03a", name = "Gros Sac de Weed"},
		{model = "bkr_prop_weed_01_small_01a", name = "Plante de Weed"},
		{model = "bkr_prop_weed_dry_02b", name = "Weed"},
		{model = "bkr_prop_weed_table_01a", name = "Table de Weed"},
		{model = "bkr_prop_coke_block_01a", name = "Block de Coke"},
	},
	AimWeapons = {
        "WEAPON_PISTOL",
        "WEAPON_COMBATPISTOL",
        "WEAPON_APPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_PISTOL_MK2",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_FLAREGUN",
        "WEAPON_STUNGUN",
        "WEAPON_REVOLVER",
    },
    DrawingWeapons = {
        "WEAPON_PISTOL",
        "WEAPON_COMBATPISTOL",
        "WEAPON_APPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_PISTOL_MK2",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_FLAREGUN",
        "WEAPON_STUNGUN",
        "WEAPON_REVOLVER",
    }
}