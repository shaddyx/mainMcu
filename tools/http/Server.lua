local ClassTools = require("tools/ClassTools")
local net = net or require("tools/NetLinux")
local Request = require("tools/http/Request")
local HEADER_DIV = ": "
local SPACE=" "
local Response = ClassTools.create({
    outputData="",
    status=200,
    textStatus="OK",
    http="HTTP/1.1",
    constructor=function(self, connection, request)
        self.headers={}
        self.connection = connection
        self.request = request
    end,
    write=function(self, data)
        self.outputData = self.outputData..data
    end,
    writeHeader=function(self, name, data)
        self.headers[name] = data
    end,
    _makeHeaders=function(self)
        local data = ""
        for k, v in pairs(self.headers) do
            data = data..self.request.divider.divider..k..HEADER_DIV..v
        end
        return data
    end,
    getOutputData=function(self)
        return self.http..SPACE..self.status..SPACE..self.textStatus..
                self:_makeHeaders()..self.request.divider.headerDivider..self.outputData
    end
});
local HttpServer = ClassTools.create({
    constructor=function(self, callBack)
        self.callBack = callBack
        self.server = net.createServer(net.TCP)
    end,
    listen=function(self, port)
        self.server:listen(port, function(conn)
            conn:on("receive", function(client,request)
                local parsedReq = Request.parse(request)
                local response = Response.new(conn, parsedReq)
                self.callBack(parsedReq, response)
                conn:send(response:getOutputData())
                conn:close()
            end)
        end)
    end
})

local Http = {
    createServer=function(callBack)
        return HttpServer.new(callBack)
    end
}
return Http