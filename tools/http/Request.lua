local StringTools = require("tools/StringTools")
local DIVIDER="\n"
local HEADER_DIVIDER=DIVIDER..DIVIDER
local Request = {

    parse=function(self, request)
        //string.gsub(request
        local chunks = StringTools.split(request, HEADER_DIVIDER)
        return {
            chunks=chunks
        }
    end
}

return Request
