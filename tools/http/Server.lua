local ClassTools = require("tools/ClassTools")
if (net == nil) then
    local NetLinux = require("tools/NetLinux")
end
HttpServer = ClassTools.create({
    constructor=function(self, port)
        self.port = port
    end
})