if (not file) then
    file = require("tools/FileLinux")
end 
require("tools/ArrayTools")
require("tools/StringTools")
FileTools = {}
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
            if not d~=nil then
                dat = dat..d
            end
        until not d~=nil
        file.close()
        return dat
    end
    function FileTools.fileExists(name)
        if (string.starts(name, "./")) then
            name = string.sub(name, 3, string.len(name))
        end
        return ArrayTools.contains(file.list(), name) or ArrayTools.contains(file.list(), "./"..name) 
    end