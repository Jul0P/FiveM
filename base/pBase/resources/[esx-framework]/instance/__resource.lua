resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
version '1.0'

shared_script '@es_extended/imports.lua'

client_scripts {
	'shared/config.lua',
	'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'shared/config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended'
}

