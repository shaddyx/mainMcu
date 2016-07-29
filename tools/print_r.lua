function prin_r (t, retValue)
    local result = ""
    local function prin(string)
        if (not retValue) then
            print(string)
        else
            result = result.."\n"..string
        end
    end
    local prin_r_cache={}
    local function sub_prin_r(t,indent)
        if (prin_r_cache[tostring(t)]) then
            prin(indent.."*"..tostring(t))
        else
            prin_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        prin(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_prin_r(val,indent..string.rep(" ",string.len(pos)+8))
                        prin(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        prin(indent.."["..tostring(pos).."] => "..tostring(val))
                    end
                end
            else
                prin(indent..tostring(t))
            end
        end
    end
    sub_prin_r(t,"  ")
    if (retValue) then
        return result
    end
end
return prin_r