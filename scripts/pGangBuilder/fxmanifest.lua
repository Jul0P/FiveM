fx_version 'adamant'
games { 'gta5' }

lua54 'yes'

escrow_ignore {
    "shared/config.lua"
}

shared_scripts {
    "shared/config.lua",
    --"@es_extended/imports.lua", -- activer cette ligne que si LastLegacy est en true dans le config
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
    "client/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "server/*.lua",
}