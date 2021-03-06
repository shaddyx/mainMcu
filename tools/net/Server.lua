-- @disableUpload
local ClassTools = require("tools/ClassTools")
local uv = require('uv')
local EventDispatcher = require("tools/EventTools")
local Logging = require("tools/Logging")
local Server = ClassTools.create({
    host="*",
    port=0
}, EventDispatcher)

local TCPServer = ClassTools.create({
    clientSockets={},
    listen=function(self, port, cb)
        self.port = port
        self.connectedCB = cb;
        self.server = uv.new_tcp()
        if (self.host == "*") then
            self.host="0.0.0.0"
        end
        self.server:bind(self.host, self.port)
        local my = self
        self.server:listen(self.port, function(err)
            local client = uv.new_tcp()
            my.server:accept(client)
            local wrappedClient = ClassTools.create({
                send=function(self, data, cb)
                    Logging.debug("TCP", "sending output data", data)
                    client:write(data)
                    Logging.debug("TCP", "output data sent", data)
                    self:fire("sent", self)
                    if cb then
                        cb()
                    end
                end,
                close=function(self)
                    self:fire("closed")
                    client:close()
                end
            }, EventDispatcher).new();
            my.connectedCB(wrappedClient)
            client:read_start(function(err, data)
                if (data ~= nil) then
                    wrappedClient:fire("receive", wrappedClient, data, err)
                else
                    wrappedClient:close()
                end
            end)

        end)
    end,
}, Server)

local UDPServer = ClassTools.create({

}, Server)

return {Server=Server, TCPServer=TCPServer, UDPServer=UDPServer}