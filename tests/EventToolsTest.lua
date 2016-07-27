-- @disableUpload
require("tools/EventTools")

TestEventTools = {}
    
    function TestEventTools:testNew()
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
