-- @disableUpload

local StringTools = require("tools/StringTools")
lu = require('luaunit')

local TestStringTools = {}
    function TestStringTools:testSplit()
        local str = "a,b,c,d"
        local res = StringTools.split(str, ",")
        lu.assertEquals(table.getn(res), 4)
    end
    function TestStringTools:testSplitMax()
        local str = "a,b,c,d"
        local res = StringTools.split(str, ",", 1)
        lu.assertEquals(table.getn(res), 2)
    end
return TestStringTools