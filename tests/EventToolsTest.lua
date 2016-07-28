-- @disableUpload
require("tools/EventTools")

TestEventTools = {}
    
    function TestEventTools:testFire()
        local called = false
        local testClass = EventDispatcher.new({
        })
        testClass:on("fired", 
            function(e)
                print("event:"..e)
            end
        )
        testClass:fire("fired", 1)
        testClass:fire("firedd", 1)
    end

    function TestEventTools:testRemove()
        local called = false
        local testClass = EventDispatcher.new({
        })
        local listener = function(e)
            called = true
        end
        testClass:on("fired_toremove", listener)
        testClass:fire("fired_toremove")
        lu.assertTrue(called)
        
        testClass:removeListener("fired_toremove", listener)
        testClass:fire("fired_toremove")
        lu.assertFalse(called)
    end
