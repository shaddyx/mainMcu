-- @disableUpload
local ClassTools = require("tools/ClassTools")

local TestClassTools = {}
    
    function TestClassTools:testNew()
        local called = false
        local MyClass = ClassTools.create({
            constructor=function(self, a , b ,c)
                print ("called"..a.." "..b.." "..c.." ")
                lu.assertEquals(a, 1)
                lu.assertEquals(2, b)
                lu.assertEquals(3, c)
                called = true
            end
        })
        MyClass.new(1,2,3)
        lu.assertTrue(called)
    end
    function TestClassTools:testConstructor()
        local constructorSelf=nil
        local MyClass = ClassTools.create({
            constructor=function(self, a,b,c)
                print("Constructor called")
                constructorSelf = self
            end
        })
        local instance = MyClass.new()
        lu.assertEquals(instance, constructorSelf)
    end
    function TestClassTools:testInheritance()
        local instance;
        local instance1;
        local MyClass = ClassTools.create({
            constructor=function(self, a,b,c)
                print("Constructor1 called")
            end,
            a=function(self)
                print ("A called")
                lu.assertEquals(self, instance)
            end,
            d=function(self)
                print ("D called")
                lu.assertEquals(self, instance1)
            end
        })
        local MyClassChild = ClassTools.create({
            b=function(self)
                print ("B called")
                lu.assertEquals(self, instance1)
            end
        }, MyClass)
        instance = MyClass.new()
        instance1 = MyClassChild.new()
        instance:a()
        instance1:b()
        instance1:d()
        --print ("instance:"..tostring(instance1))
    end
return TestClassTools