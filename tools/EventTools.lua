require("tools/ClassTools")
require("tools/ArrayTools")
EventDispatcher = ClassTools.create({
    on=function(self, e, l)
        self.__events = self.__events or {}
        self.__events[e] = self.__events[e] or {}
        table.insert(self.__events[e], l)
    end,
    fire=function(self, e, ...)
        if ((not self.__events) or (not self.__events[e]))then 
            return
        end
        for k,v in pairs(self.__events[e]) do v(...) end
    end,
    removeListener=function(self, e, listener)
    if ((not self.__events) or (not self.__events[e]))then 
            return
        end
        local index = ArrayTools.indexOf(self.__events[e], listener)
        if (index ~= -1) then
            table.remove(self.__events[e], index)
        end
    end
})