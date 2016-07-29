-- @disableUpload
EXPORT_ASSERT_TO_GLOBAL=true
lu = require('luaunit')
TestFileTools = require("tests/fileToolsTest")
TestArrayTools = require("tests/ArrayToolsTest")
TestClassTools = require("tests/ClassToolsTest")
TestEventTools = require("tests/EventToolsTest")
TestNetLinux = require("tests/NetLinuxTest")
os.exit(lu.LuaUnit.run());