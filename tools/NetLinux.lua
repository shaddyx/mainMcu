-- @disableUpload
local socket = require("socket")
require("tools/net/Socket")
local serv = require("tools/net/Server");
local Server = serv.Server
local TCPServer = serv.TCPServer
local UDPServer = serv.UDPServer
print (tostring(TCPServer))

local Socket = ClassTools.create({
    constructor=function(self, sock)
    end,
    send=function(data)
    end
}, EventDispatcher)

local net = {
    TCP=1,
    UDP=2
}
    function net.createServer(type, timeout)
        assert(type == net.TCP or type == net.UDP)
        if (type == net.TCP) then
            return TCPServer.new(timeout or 0)
        elseif (type == net.UDP) then
            return UDPServer.new(timeout or 0)
        end
    end


--
--local Server = ClassTools.create({
--}, EventDispatcher)
--
--local TCPServer = ClassTools.create({
--    listen=function(self)
--        self.server = socket.try(socket.bind("*", 0))
--    end
--}, Server)
--
--local UDPServer = ClassTools.create({
--    listen=function(self, port, cb)
--        self.udp = assert(socket.udp())
--        assert(self.udp:setsockname(self.host, port))
--        assert(self.udp:settimeout(5))
--        ip, port = self.udp:getsockname()
--        while 1 do
--            dgram, ip, port = udp:receivefrom()
--            if dgram then
--                self:fire("receive", self, tostring(dgram))
--                --udp:sendto(dgram, ip, port)
--            else
--                print(ip)
--            end
--        end
--    end
--}, Server)
--
--net = {
--    TCP=1,
--    UDP=2
--}
--    function net.createServer(type)
--        if (type == net.TCP) then
--            return TCPServer.new()
--        elseif (type == net.UDP) then
--            return UDPServer.new()
--        end
--    end

return net