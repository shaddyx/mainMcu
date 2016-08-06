local FileTools = require("tools/FileTools")
local http = require("tools/http/Server")
print('init.lua ver 1.2')
function connectWifi()
    wifi.setmode(wifi.STATION)
    print('set mode=STATION (mode='..wifi.getmode()..')')
    print('MAC: ',wifi.sta.getmac())
    print('chip: ',node.chipid())
    print('heap: ',node.heap())
    -- wifi config start
    wifi.sta.config("Shaddy_2.4","innocent")
    -- wifi config end
end
connectWifi()
local server = http.createServer(function(req, res)
    res:write("OOOOK")
end):listen(8088)