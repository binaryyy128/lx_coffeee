games {'gta5'}

fx_version 'cerulean'

description 'Coffee script by Lxnnard'
version '1.0.0'

client_script 'config.lua'
client_script '@NativeUI/NativeUI.lua'

client_scripts {
    'client/main.lua'
}

server_script 'config.lua'

server_scripts {
    'server/main.lua'
}

dependencies {
    'NativeUI'
}

shared_script '@es_extended/imports.lua'