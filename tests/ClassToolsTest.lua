-- @disableUpload
require("tools/ClassTools")

TestClassTools = {}
    
    function TestClassTools:testNew()
        local called = false
        local MyClass = ClassTools.create({
            constructor=function(self, a,b,c)
                --print ("called"..a.." "..b.." "..c.." ")
                lu.assertEquals(a, 1)
                lu.assertEquals(2, b)
                lu.assertEquals(3, c)
                called = true
            end
        })
        MyClass.new(1,2,3)
        lu.assertTrue(called)
    end
