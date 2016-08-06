-- @disableUpload
local http = require("tools/http/Server")
local server = http.createServer(function(req, res)
    res:write("OOOOK")
end):listen(8088)
