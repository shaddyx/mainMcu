-- @disableUpload
local ClassTools = require("tools/ClassTools")
local Socket = require("tools/net/Socket")
local Server = ClassTools.create({
    host="*",
    port=0,
    constructor=function(self, timeout)
        self.timeout = timeout
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
        print("i:"..tostring(self.i).." p:"..tostring(self.p))
    end,
    checkAccept=function(self)
        local c, e = self.serverSocket:accept()
        return c
    end,

    checkReadsWrites=function(self)
        local recvSocksToCheck = {}
        local sendSocksToCheck = {}
        for nativeSocketString, sock in pairs(self.clientSockets) do
            table.insert(socksToCheck, sock.__nativeSocket)
            if (sock._data) then
                table.insert(sendSocksToCheck, sock.__nativeSocket)
            end
        end
        socket.select(recvSocksToCheck, sendSocksToCheck)
        for key, nativeSocket in pairs(recvSocksToCheck) do
            self.clientSockets[tostring(nativeSocket)]:_readData()
        end
        for key, nativeSocket in pairs(sendSocksToCheck) do
            self.clientSockets[tostring(nativeSocket)]:_writeData()
        end

    end,
    check=function(self)
        local sock = self:checkAccept()
        if (sock) then
            local clientSocket = Socket.new(sock)
            self.clientSockets[tostring(clientSocket._nativeSocket)] = clientSocket;
            self.connectedCB(clientSocket)
        end
        self:checkReadsWrites()
    end
}, Server)

local UDPServer = ClassTools.create({

}, Server)

return {Server=Server, TCPServer=TCPServer, UDPServer=UDPServer}