local StringTools = {}
    function StringTools.starts(String,Start)
        return string.sub(String,1,string.len(Start))==Start
    end

    function StringTools.ends(String,End)
        return End=='' or string.sub(String,-string.len(End))==End
    end
    function StringTools.split(inputstr, sep, maxCount)
        if sep == nil then
            sep = "%s"
        end
        local t={}; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            if maxCount == nil or i <= maxCount then
                t[i] = str
                i = i + 1
            else
                if t[i] then
                    t[i] = t[i]..sep..str
                else
                    t[i] = str
                end
            end
        end
        return t
    end
return StringTools