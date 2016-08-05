local StringTools = require("tools/StringTools")
local Request = {
    parse=function(self, request)
        local chunks = StringTools.split(request, "\n")

        return {
            chunks=chunks
        }
    end
}

return Request
