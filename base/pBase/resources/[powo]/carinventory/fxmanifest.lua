fx_version 'adamant'
game 'gta5'
version '1.2.1'
lua54 'yes'
author ('ZEDKOVER#1714')

shared_script '@es_extended/imports.lua'

escrow_ignore {
  'config.lua',
  'cl_esx.lua',
  'sv_esx.lua'
}
server_scripts {
  "@es_extended/locale.lua",
  -- "sv_esx.lua",
  "@oxmysql/lib/MySQL.lua",
  "locales/fr.lua",
  "locales/en.lua",
  "config.lua",
  "server/classes/c_trunk.lua",
  "server/trunk.lua",
  "server/esx_trunk-sv.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  -- "cl_esx.lua",
  "locales/fr.lua",
  "locales/en.lua",
  "config.lua",
  "client/esx_trunk-cl.lua"

}

