fx_version 'adamant'
games {'gta5'}
lua54 'yes'
author ('ZEDKOVER#1714')

shared_script '@es_extended/imports.lua'

escrow_ignore {
  'config.lua',
  'cl_esx.lua',
  'sv_esx.lua'
}

ui_page 'html/ui.html'

client_scripts {
  "@es_extended/locale.lua",
  -- "cl_esx.lua",
  "utils.lua",
  'config.lua',
  -- "locales/*.lua",
  "RageUI/RMenu.lua",
  "RageUI/menu/RageUI.lua",
  "RageUI/menu/Menu.lua",
  "RageUI/menu/MenuController.lua",
  "RageUI/components/*.lua",
  "RageUI/menu/elements/*.lua",
  "RageUI/menu/items/*.lua",
  "RageUI/menu/panels/*.lua",
  "RageUI/menu/windows/*.lua",
  "clothshop/cl_clothshop.lua",
  "client/*.lua",
  "clothvariation/Variations.lua",
  "clothvariation/Functions.lua",
  "clothvariation/Clothing.lua",
  "ammo/cl_ammo.lua"
}

server_scripts {
  "@es_extended/locale.lua",
  "@oxmysql/lib/MySQL.lua",
  -- "sv_esx.lua",
  'config.lua',
  -- "locales/*.lua",
  "server/*.lua",
  "clothshop/sv_clothshop.lua",
  "ammo/sv_ammo.lua"
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/locales/*.js',
    'html/img/*.png',
    'html/img/items/*.png',
    'html/img/cloth/*.svg'
}
