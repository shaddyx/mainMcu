-- @disableUpload
local socket = require("socket")
require("tools/ClassTools")
local Server = ClassTools.create({
})
net = {
    TCP=1,
    UDP=2
}

    function net.createServer(type)
        return Server
    end

return net