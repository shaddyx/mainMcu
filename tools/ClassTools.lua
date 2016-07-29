local ClassTools = {}
function ClassTools.create(child, parent)
    local mtable = {}
    if (parent) then
        mtable.__index = parent
    end
    setmetatable(child, mtable)
    child.new = function(...)
        local instance={}
        setmetatable(instance, {
            __index=child
        })
        if (instance.constructor) then
            instance.constructor(instance, ...)
        end
        return instance
    end
    return child
end
return ClassTools