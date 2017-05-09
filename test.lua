local Router = require("tools/http/Router")
local print_r = require("tools/print_r")
local router = Router.new({
});
router:add("/", function(req, res)
    return "<script type='text/javascript'>window.location.href='/html/index.html';</script>"
end)
router:add("/test/.*/", function(req, res)
    return "Regex match:"..print_r(req,1)
end)
router:addFileMatcher("html/")
local server = router:createServer(8088)
