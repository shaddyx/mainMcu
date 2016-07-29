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

--local socket = require("socket")
--local print_r = require("tools/print_r")
--host = host or "*"
--port = port or 8089
--
--local s = assert(socket.bind(host, port))
--print("server:"..tostring(s))
--i, p   = s:getsockname()
--assert(i, p)
--print("i:"..tostring(i).." p:"..tostring(p))
--print("Waiting connection from client on " .. i .. ":" .. p .. "...")
--s:settimeout(0.1)
--
--function tryToAccept(socket)
--    local c, e = s:accept()
--    return c
--end
--
--function tryToReceive(c)
--    print ("Selecting")
--    readyForRead, readyForWrite, e = socket.select({c}, {}, 0.01)
--    print (string.format("readyForRead:%s, readyForWrite:%s, e:%s", print_r(readyForRead, 1) , print_r(readyForWrite, 1), tostring(e)))
--    if (readyForRead) then
--        d, e = c:receive()
--        return d, e
--    end
--    return nil, nil
--end
--
--repeat
--    local c = tryToAccept()
--    if (c) then
--        print ("connected:"..tostring(c))
--        repeat
--            print ("recv")
--            l, e = tryToReceive(c)
--        until e
--    end
--    print("disconnected")
--until false
--
--function netLoop()
--    local c, e = s:accept()
--
--end