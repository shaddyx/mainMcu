-- @disableUpload
local data = [[GET /favicon.ico HTTP/1.1
Host: localhost:8094
Connection: keep-alive
Pragma: no-cache
Cache-Control: no-cache
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36
Accept: */*
Referer: http://localhost:8094/?mode=1
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8,ru;q=0.6






text
]]

-- @disableUpload
local Request = require("tools/http/Request")
local print_r = require("tools/print_r")
TestRequest = {}

    function TestRequest:testCreateServer()
        print "Called!!!"
        local req = Request.parse(data)
        print_r(req)
    end
return TestRequest