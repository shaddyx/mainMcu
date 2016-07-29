-- @disableUpload
local ClassTools = require("tools/ClassTools")
local Socket = ClassTools.create({
    data="",
    constructor=function(self, sock)
        self.nativeSocket=sock
    end,
    send=function(self, data)
        self.data=self.data+data
    end
}, EventDispatcher)

return Socket;