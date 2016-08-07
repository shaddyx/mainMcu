if (not file) then
    file = require("tools/FileLinux")
end

local ArrayTools = require("tools/ArrayTools")
local StringTools = require("tools/StringTools")
local FileTools = {}
    function FileTools.filePutContents(name, data)
        file.open(name, "w+")
        file.write(data)
        file.close()
    end
    function FileTools.fileGetContents(name)
        file.open(name, "r")
        local dat=''
        repeat
            local d=file.read()
            if (d~=nil) then
                dat = dat..d
            end
        until d==nil or d==""
        file.close()
        return dat
    end
    function FileTools.fileExists(name)
        if (StringTools.starts(name, "./")) then
            name = string.sub(name, 3, string.len(name))
        end
        return ArrayTools.contains(file.list(), name) or ArrayTools.contains(file.list(), "./"..name)
    end
return FileTools