fx_version 'adamant'

game 'gta5'

version '1.1.9'

client_scripts {
    'config.lua',
    'notif.lua',
    -- 'demo.lua'
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/images/*.jpg',
    'ui/images/*.png',
    -- 'ui/audio/*.ogg',
    -- 'ui/audio/*.mp3',
    -- 'ui/audio/*.wav',
    -- 'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js'
}

exports {
    'Send',
    'SendAdvanced',
    'SendSuccess',
    'SendInfo',
    'SendWarning',
    'SendError',
    'SendPinned',
    'Unpin',
    'UpdatePinned'
}
