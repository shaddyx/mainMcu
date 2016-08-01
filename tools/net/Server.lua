-- @disableUpload
local ClassTools = require("tools/ClassTools")
local Socket = require("tools/net/Socket")
local print_r = require("tools/print_r")
local Server = ClassTools.create({
    host="*",
    port=0,
    constructor=function(self, timeout)
        self.timeout = timeout or 0.001
    end
}, EventDispatcher)

local TCPServer = ClassTools.create({
    clientSockets={},
    listen=function(self, port, cb)
        self.port = port
        self.connectedCB = cb;
        if (self.serverSocket) then
            error("Server already serving")
        end
        self.serverSocket = assert(socket.bind(self.host, self.port))
        self.serverSocket:settimeout(0.01)
        self.i, self.p = self.serverSocket:getsockname()
    end,
    checkAccept=function(self)
        local c, e = self.serverSocket:accept()
        return c, e
    end,

    removeClosed=function(self)
        local i, v = next(self.clientSockets, nil)
        while i do
            if (v._closed) then
                self.clientSockets[i].fire("closed")
                self.clientSockets[i]=nil
            end
            i, v = next(self.clientSockets, i)
        end
    end,

    checkReadsWrites=function(self)
        local recvSocksToCheck = {}
        local sendSocksToCheck = {}
        for nativeSocketString, sock in pairs(self.clientSockets) do
            table.insert(recvSocksToCheck, sock.__nativeSocket)
            if (sock._data) then
                table.insert(sendSocksToCheck, sock.__nativeSocket)
            end
        end
        local readyForRead, readyForWrite, e = socket.select(recvSocksToCheck, sendSocksToCheck, self.timeout)
        if (e and e~="timeout") then
            print("Error:"..tostring(e))
        end
        if (table.getn(readyForRead) > 0) then
            for key, nativeSocket in pairs(readyForRead) do
                local sock = self.clientSockets[tostring(nativeSocket)]
                if (sock) then
                    sock:_readData()
                end
            end
        end
        for key, nativeSocket in pairs(readyForWrite) do
            self.clientSockets[tostring(nativeSocket)]:_writeData()
        end
        self:removeClosed()

    end,
    check=function(self)
        local sock = self:checkAccept()
        if (sock) then
            print "Creating new socket"
            local clientSocket = Socket.new(sock)
            self.clientSockets[tostring(clientSocket.__nativeSocket)] = clientSocket;
            self.connectedCB(clientSocket)
        end
        self:checkReadsWrites()
    end
}, Server)

local UDPServer = ClassTools.create({

}, Server)

return {Server=Server, TCPServer=TCPServer, UDPServer=UDPServer}