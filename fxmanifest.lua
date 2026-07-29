fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Rx Framework Team'
description 'Provides the logic for handling cryptocurrency aka qbit'
version '1.2.1'

shared_scripts {
    '@rx-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config/config.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
client_script 'client/main.lua'

dependency 'rx-minigames'
