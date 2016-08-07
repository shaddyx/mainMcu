local ClassTools = require("tools/ClassTools")
local http = require("tools/http/Server")
local FileTools = require("tools/FileTools")
local StringTools = require("tools/StringTools")
local processFile=function(req,res,path)
    --local len = string.len(path)
    local ext=StringTools.split(req.path,"/")
    return FileTools.fileGetContents(req.path);
end
local Router = ClassTools.create({
    constructor=function(self,routesTable)
        self.routes=routesTable or {}
    end,
    add=function(self, route, cb)
        self.routes[route]=cb
    end,
    addFileMatcher=function(path)
        self.routes[path..".*"]=function(req,res)
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
                if (string.match(route, "^"..k.."$")) then
                    return v
                end
            end
        end
        return res
    end,
    httpCallback=function(self, req, res)
        local cb=self:get(req.path)
        if (cb==nil) then
            self:errorPage(404, string.format("Error, page[%s] not found", req.path), req, res)
        else
            local result=cb(req, res)
            if (result) then
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