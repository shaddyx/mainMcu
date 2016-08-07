-- @disableUpload
local f
local File = {}

    function File.open(name, mode)
        f = assert(io.open(name, mode))
    end
    function File.read()
        io.input(f)
        return io.read("*a")
    end
    function File.readline()
        io.input(f)
        return io.read()
    end
    function File.write(data)
        io.output(f)
        io.write(data)
    end
    function File.close()
        io.close(f)
    end
    function File.list()
        return File.scandir("./")
    end
    function File.scandir(directory)
        
        local i, t, popen = 0, {}, io.popen
        local pfile = popen('ls -a "'..directory..'"')
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
        return t
    end

return File