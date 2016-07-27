local FileTools = require("tools/FileTools")
print('init.lua ver 1.2')
function connectWifi()
    wifi.setmode(wifi.STATION)
    print('set mode=STATION (mode='..wifi.getmode()..')')
    print('MAC: ',wifi.sta.getmac())
    print('chip: ',node.chipid())
    print('heap: ',node.heap())
    -- wifi config start
    wifi.sta.config("Shaddy","innocent")
    -- wifi config end
end
print(FileTools.fileGetContents("init.lua"))