Config = {}
Config.Locale = GetConvar('esx:locale', 'fr')
Config.Visible = true

Config.Items = {
	["pain"] = {
		type = "food",
		prop= "prop_cs_burger_01",
		status = 200000,				 
		remove = true
	},
	["eau"] = {
		type = "drink",
		prop = "prop_ld_flow_bottle",
		status = 100000,
		remove = true
	},
	["biere"] = {
		type = "drunk",
		prop = "prop_ld_flow_bottle",
		status = 100000,
		remove = true
	}
}
