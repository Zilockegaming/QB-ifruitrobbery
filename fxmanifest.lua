fx_version 'cerulean'
game 'gta5'

description 'qb-ifruitstorerobbery'
version '0.2'

ui_page 'html/index.html'

shared_script {'config.lua'
}

client_script {
    'client/main.lua'
}

server_script{ 
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}

lua54 'yes'


