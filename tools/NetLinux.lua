-- @disableUpload
local socket = require("socket")
require("tools/ClassTools")
require("tools/EventTools")
local Socket = ClassTools.create({
    constructor:function(self, sock)
    end,
    send:function(data)
    end
}, EventDispatcher)

local Server = ClassTools.create({
}, EventDispatcher)

local TCPServer = ClassTools.create({
    listen=function(self)
        self.server = socket.try(socket.bind("*", 0))
    end
}, Server)

local UDPServer = ClassTools.create({
    listen=function(self, port, cb)
        self.udp = assert(socket.udp())
        assert(self.udp:setsockname(self.host, port))
        assert(self.udp:settimeout(5))
        ip, port = self.udp:getsockname()
        while 1 do
            dgram, ip, port = udp:receivefrom()
            if dgram then
                self:fire("receive", self, tostring(dgram))
                --udp:sendto(dgram, ip, port)
            else
                print(ip)
            end
        end
    end
}, Server)

net = {
    TCP=1,
    UDP=2
}
    function net.createServer(type)
        if (type == net.TCP) then 
            return TCPServer.new()
        elseif (type == net.UDP) then 
            return UDPServer.new()
        end
    end

return net