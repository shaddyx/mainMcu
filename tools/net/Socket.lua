-- @disableUpload
local ClassTools = require("tools/ClassTools")
local EventDispatcher = require("tools/EventTools")
local Socket = ClassTools.create({
    _data=nil,
    _closed=false,
    constructor=function(self, sock)
        print ("Self"..tostring(self))
        print ("Sock"..tostring(sock))
        self.__nativeSocket=sock
    end,
    send=function(self, data)
        self._data= self._data + data
    end,
    _readData=function(self)
        local data, e = self.__nativeSocket:receive()
        if (e == "closed") then
            self._closed = true
        end
        if (data) then
            self:fire("receive", nil, data)
        end
    end,
    _writeData=function(self)
        print "sending"
        local lastIndex = self.__nativeSocket:send(self.data)
        self.data = string.sub(self.data, lastIndex)
    end
}, EventDispatcher)

return Socket;