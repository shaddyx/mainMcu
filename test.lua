--for k,v in pairs({a=1,b=2}) do
--    print("k:"..tostring(k))
--    print("v:"..tostring(v))
--end
local net = require("tools/NetLinux")
local server = net.createServer(net.TCP)
server:listen(8094, function(conn)
    print ("connected CB:"..tostring(conn))
    conn:on("receive", function(client, request)
        print ("Data received:"..tostring(request))
    end)
    conn:on("closed", function(client)
        print ("Connection closed")
    end)
end)
while true do
    server:check()
end