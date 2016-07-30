local net = require("tools/NetLinux")
local server = net.createServer(net.TCP)
server:listen(8094, function(conn)
    print ("connected CB:"..tostring(conn))
    conn:on("receive", function(client, request)
        print ("Data received:"..request)
    end)
end)
while true do
    server:check()
end