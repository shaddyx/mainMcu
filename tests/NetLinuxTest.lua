-- @disableUpload
local net = require("tools/NetLinux")
local print_r = require("tools/print_r")
TestNetLinuxTools = {}
    
    function TestNetLinuxTools:testCreateServer()
        local server = net.createServer(net.TCP)
        print_r(server)
    end
