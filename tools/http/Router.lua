local ClassTools = require("tools/ClassTools")
local http = require("tools/http/Server")
local FileTools = require("tools/FileTools")
local StringTools = require("tools/StringTools")
local Logging = require("tools/Logging")
local mimeTypes={
    htm="text/html",
    html="text/html",
    jpg="image/jpeg",
    png="image/png",
    css="text/css",
    json="application/json"
}
local processFile=function(req,res,path)
    local localPath=string.sub(req.path, 2)
    if (not FileTools.fileExists(localPath)) then
        return "Not found:"..localPath
    end
    --local len = string.len(path)
    local extChunks=StringTools.split(req.path,"/")
    local extLen=table.getn(extChunks)
    local cType="application/octet-stream"
    if (extLen > 0) then
        local file=extChunks[extLen]
        extChunks = StringTools.split(file,".")
        local extLen=table.getn(extChunks)
        if (extLen > 0) then
            local ext = extChunks[extLen]
            cType = mimeTypes[ext] or cType
        end
    end
    res:writeHeader("Content-Type", cType)
    return FileTools.fileGetContents(localPath)
end
local Router = ClassTools.create({
    constructor=function(self,routesTable)
        self.routes=routesTable or {}
    end,
    add=function(self, route, cb)
        self.routes[route]=cb
    end,
    addFileMatcher=function(self,path)
        self.routes["/"..path..".*"]=function(req,res)
            return processFile(req, res, path)
        end
    end,
    remove=function(self, route)
        self.routes[route]=nil
    end,
    get=function(self, route)
        local res = self.routes[route]
        if (res==nil) then
            for k,v in pairs(self.routes) do
                if (route and string.match(route, "^"..k.."$")) then
                    return v
                end
            end
        end
        return res
    end,
    httpCallback=function(self, req, res)
        local cb=self:get(req.path)
        Logging.debug("ROUTER", "HTTP callback", req, res)
        if (cb==nil) then
            Logging.debug("ROUTER", "No page found", req.path)
            self:errorPage(404, string.format("Error, page[%s] not found", req.path), req, res)
        else
            Logging.debug("ROUTER", "Redirrecting to cb", req.path)
            local result=cb(req, res)
            if (result) then
                Logging.debug("ROUTER", "Writing data for: "..req.path..", result:"..result)
                res:write(result)
            end
        end
    end,
    errorPage=function(self, status, text, req, res)
        res.status=status
        res:write(text)
    end,
    createServer=function(self, port)
        local my=self
        self.server = http.createServer(function(req, res)
            my:httpCallback(req,res)
        end):listen(port)
    end
})

return Router