local Server = ClassTools.create({
    constructor=function(self, timeout)
        self.timeout = timeout
    end
}, EventDispatcher)

local TCPServer = ClassTools.create({

}, Server)

local UDPServer = ClassTools.create({

}, Server)

return {Server=Server, TCPServer=TCPServer, UDPServer=UDPServer}