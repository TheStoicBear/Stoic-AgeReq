fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'TheStoicBear'
description 'Age verification script using ox_lib'
version '1.0.0'
dependency 'ox_lib'
-- Client Scripts
client_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'src/client.lua'
}
-- Server Scripts
server_scripts {
    'config.lua',
    'src/server.lua'
}


