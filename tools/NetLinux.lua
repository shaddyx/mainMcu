-- @disableUpload
local socket = require("socket")
local serv = require("tools/net/Server");
local Socket = require("tools/net/Socket")
local Server = serv.Server
local TCPServer = serv.TCPServer
local UDPServer = serv.UDPServer
print (tostring(TCPServer))

local net = {
    TCP=1,
    UDP=2,
    recvSockets={},
    sendSockets={}
}
    function net.createServer(type, timeout)
        assert(type == net.TCP or type == net.UDP)
        if (type == net.TCP) then
            return TCPServer.new(timeout or 0)
        elseif (type == net.UDP) then
            return UDPServer.new(timeout or 0)
        end
    end
    function net.check()

    end

    function net.serveForever()
    end
return net