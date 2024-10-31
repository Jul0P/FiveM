fx_version 'cerulean'
games { 'gta5' };
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts {
    "shared/config.lua"
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "@es_extended/locale.lua",
    "client/*.lua"
}

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}

server_scripts {
    --"@mysql-async/lib/MySQL.lua",
    '@oxmysql/lib/MySQL.lua',
    "@es_extended/locale.lua",
    "server/*.lua"
}

dependencies {
	'es_extended'
}