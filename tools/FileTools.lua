FileTools = {}
    function FileTools.filePutContents(name, data)
        file.open(name, "w+")
        print(file.write())
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
        return file.list()[name]
    end

return FileTools