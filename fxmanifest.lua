--#--
--Fx info--
--#--
fx_version   "cerulean"
use_fxv2_oal "yes"
lua54        "yes"
game         "gta5"
version      "1.0.0"


--#--
--Manifest--
--#--
client_scripts   {
    "client/*.lua"
}

server_scripts   {
    '@oxmysql/lib/MySQL.lua',

    "server/*.lua"
}

shared_scripts  {
    "@ox_lib/init.lua",
    "shared/*.lua",
}

ui_page "web/index.html"

files {
    "web/index.html",
    "web/css/reset.css",
    "web/css/style.css",
    "web/js/app.js"
}