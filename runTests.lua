-- @disableUpload
local lu = require('luaunit')
_G.TestFileTools = require("tests/fileToolsTest")
_G.TestArrayTools = require("tests/ArrayToolsTest")
_G.TestClassTools = require("tests/ClassToolsTest")
_G.TestEventTools = require("tests/EventToolsTest")
_G.TestNetLinux = require("tests/NetLinuxTest")
_G.TestNetLinux = require("tests/http/RequestTest")

os.exit(lu.LuaUnit:run());