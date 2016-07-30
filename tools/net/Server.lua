-- @disableUpload
local ClassTools = require("tools/ClassTools")
local Socket = require("tools/net/Socket")
local print_r = require("tools/print_r")
local Server = ClassTools.create({
    host="*",
    port=0,
    constructor=function(self, timeout)
        self.timeout = timeout or 0.5
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
        return c, e
    end,

    checkReadsWrites=function(self)
        local recvSocksToCheck = {}
        local sendSocksToCheck = {}
        for nativeSocketString, sock in pairs(self.clientSockets) do
            print ("Checking:"..tostring(nativeSocketString))
            print ("Native:"..tostring(sock.__nativeSocket))
            table.insert(recvSocksToCheck, sock.__nativeSocket)
            if (sock._data) then
                table.insert(sendSocksToCheck, sock.__nativeSocket)
            end
        end
        if (next(self.clientSockets) ~= nil) then
            print("checking read")
            print_r(recvSocksToCheck)
            print("End checking read")
        end
        readyForRead, readyForWrite, e = socket.select(recvSocksToCheck, sendSocksToCheck, self.timeout)
        if (table.getn(readyForRead) > 0) then
            print ("RFoRead:"..tostring(readyForRead).. " count: "..table.getn(readyForRead))
        end
        for key, nativeSocket in pairs(readyForRead) do
            print "sockReady"
            self.clientSockets[tostring(nativeSocket)]:_readData()
        end
        for key, nativeSocket in pairs(readyForWrite) do
            self.clientSockets[tostring(nativeSocket)]:_writeData()
        end

    end,
    check=function(self)
        local sock = self:checkAccept()
        if (sock) then
            local clientSocket = Socket.new(sock)
            self.clientSockets[tostring(clientSocket._nativeSocket)] = clientSocket;
            print_r(self.clientSockets)
            self.connectedCB(clientSocket)
        end
        self:checkReadsWrites()
    end
}, Server)

local UDPServer = ClassTools.create({

}, Server)

return {Server=Server, TCPServer=TCPServer, UDPServer=UDPServer}