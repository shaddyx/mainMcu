-- @disableUpload
local f
local ArrayTools = require("tools/ArrayTools")
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
        local t, popen = {}, io.popen
        local pfile = popen('ls -a "'..directory..'"')
        for filename in pfile:lines() do
            if (filename ~= "." and filename ~= "..") then
                local fullPath = directory.."/"..filename
                if File._isdir(fullPath) then
                    local d = File.scandir(fullPath)
                    t = ArrayTools.concat(d, t)
                else
                    t[#t + 1] = fullPath:gsub("//", "/"):gsub('[\\.]/', "")
                end
            end
        end
        pfile:close()
        return t
    end
    function File._exec(proc)
        local pfile = io.popen(proc)
        local res = ""
        for line in pfile:lines() do
            res = res..line
        end
        pfile:close()
        return res
    end
    function File._isdir(directory)
        return File._exec('test -d "'..directory..'" && echo "OK"') == "OK"
    end

return File