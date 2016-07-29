-- @disableUpload
EXPORT_ASSERT_TO_GLOBAL=true
lu = require('luaunit')
require("tests/fileToolsTest")
require("tests/ArrayToolsTest")
require("tests/ClassToolsTest")
require("tests/EventToolsTest")
require("tests/NetLinuxTest")

os.exit(lu.LuaUnit.run());