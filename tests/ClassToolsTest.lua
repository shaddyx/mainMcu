-- @disableUpload
require("tools/ClassTools")

TestClassTools = {}
    
    function TestClassTools:testNew()
        local called = false
        local MyClass = ClassTools.create({
            constructor=function(a,b,c)
                --print ("called"..a.." "..b.." "..c.." ")
                lu.assertEquals(1, a)
                lu.assertEquals(2, b)
                lu.assertEquals(3, c)
                called = true
            end
        })
        MyClass.new(1,2,3)
        lu.assertTrue(called)
    end
