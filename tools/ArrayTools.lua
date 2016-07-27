ArrayTools = {}
    function ArrayTools.contains(tab, val)
        for index, value in ipairs (tab) do
            if value == val then
                return true
            end
        end
        return false
    end
    function ArrayTools.map(tab, fun)
        result = {}
        for index, value in ipairs (tab) do
            result[index] = fun(value)
        end 
        return result
    end

    function ArrayTools.filter(t, filterIter)
        local out = {}

        for k, v in pairs(t) do
            if filterIter(v, k, t) then out[k] = v end
        end
        return out
    end