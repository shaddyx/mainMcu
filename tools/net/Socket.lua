-- @disableUpload
local ClassTools = require("tools/ClassTools")
local EventDispatcher = require("tools/EventTools")
local Socket = ClassTools.create({
    _data=nil,
    constructor=function(self, sock)
        print ("Self"..tostring(self))
        print ("Sock"..tostring(sock))
        self._nativeSocket=sock
    end,
    send=function(self, data)
        self._data= self._data + data
    end,
    _readData=function(self)
        print "reading"
        local data = self._nativeSocket:receive()
        self:fire("receive", data)
    end,
    _writeData=function(self)
        print "sending"
        local lastIndex = self._nativeSocket:send(self.data)
        self.data = string.sub(self.data, lastIndex)
    end
}, EventDispatcher)

return Socket;