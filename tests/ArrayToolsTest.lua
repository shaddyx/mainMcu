-- @disableUpload
local ArrayTools = require("tools/ArrayTools")

local TestArrayTools = {}
    
    function TestArrayTools:testContains()
        local data = {"a", "b", "cc"}
        lu.assertTrue(ArrayTools.contains(data, "a"))
        lu.assertTrue(ArrayTools.contains(data, "b"))
        lu.assertTrue(ArrayTools.contains(data, "cc"))
        lu.assertFalse(ArrayTools.contains(data, "d"))
    end

    function TestArrayTools:testMap()
        local data = {"a", "b", "cc"}
        res = ArrayTools.map(data, function(val) return val.."_" end, data)
        lu.assertEquals(res[1], "a_")
    end
return TestArrayTools