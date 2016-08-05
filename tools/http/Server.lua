local ClassTools = require("tools/ClassTools")
local net = net or require("tools/NetLinux")
local HttpServer = ClassTools.create({
    constructor=function(self, callBack)
        self.callBack = callBack
        self.server = net.createServer(net.TCP)
    end,
    listen=function(self, port)
        self.server:listen(port, function(conn)
            conn:on("receive", function(client,request)

            end)
        end)
    end

})

local Http = {
    createServer=function(self, port)
        return HttpServer.new(port)
    end
}