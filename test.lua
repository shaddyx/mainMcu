-- @disableUpload
--local http = require("tools/http/Server")
--local server = http.createServer(function(req, res)
--    res:write("OOOOK")
--end):listen(8088)


local Router = require("tools/http/Router")
local print_r = require("tools/print_r")
local router = Router.new({
});
router:add("/", function(req, res)
    return "home:"..print_r(req,1)
end)
router:add("/capturing/.*/", function(req, res)
    return "Regex match:"..print_r(req,1)
end)
router:addFileMatcher("tools/")
local server = router:createServer(8088)
