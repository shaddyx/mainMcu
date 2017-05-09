local ArrayTools = {}
    function ArrayTools.contains(tab, val)
        return ArrayTools.indexOf(tab, val) ~= -1
    end
    function ArrayTools.indexOf(tab, val)
        for index, value in ipairs (tab) do
            if value == val then
                return index
            end
        end
        return -1
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
    function ArrayTools.concat(...)
        local t = {}
        for n = 1,select("#",...) do
            local arg = select(n,...)
            if type(arg)=="table" then
                for _,v in ipairs(arg) do
                    t[#t+1] = v
                end
            else
                t[#t+1] = arg
            end
        end
        return t
    end
return ArrayTools