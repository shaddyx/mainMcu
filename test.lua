local socket = require("socket")
host = host or "*"
port = port or 8089

local s = assert(socket.bind(host, port))
print("server:"..tostring(s))
i, p   = s:getsockname()
assert(i, p)
print("i:"..tostring(i).." p:"..tostring(p))
print("Waiting connection from client on " .. i .. ":" .. p .. "...")
s:settimeout(0.1)
repeat
    local c, e = s:accept()
    print("Connected!"..tostring(c).." e:"..tostring(e))
    if (c) then 
        repeat
            print ("recv")
            l, e = c:receive()
            print(l)
        until e
    end
until true

function netLoop()
    local c, e = s:accept()
end