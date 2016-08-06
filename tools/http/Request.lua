local StringTools = require("tools/StringTools")
local makeHeaderDivider=function(divider)
    return {
        divider=divider,
        headerDivider=divider..divider
    }
end
local MAXPOS=100000000000;

local DIVIDERS={
    rn=makeHeaderDivider("\r\n"),
    nr=makeHeaderDivider("\n\r"),
    n=makeHeaderDivider("\n")
}

local getPos = function(data, divider)
    local pos = string.find(data, divider.headerDivider)
    if (pos == nil) then return MAXPOS end
    return pos
end;
local detectDivider=function(data)
    local rnPos=getPos(data, DIVIDERS.rn)
    local nrPos=getPos(data, DIVIDERS.nr)
    local nPos=getPos(data, DIVIDERS.n)
    local dividerPos = math.min(rnPos, nrPos, nPos)
    if (dividerPos == rnPos) then return DIVIDERS.rn end
    if (dividerPos == nrPos) then return DIVIDERS.nr end
    if (dividerPos == nPos) then return DIVIDERS.n end
    error("Dividers not found in:"..data);
end
local processHeaders = function(headers)
    local result = {}
    for i, header in ipairs(headers) do
        if (i ~= 1) then
            local chunks = StringTools.split(header, ":", 1)
            if (table.getn(chunks) > 1) then
                result[chunks[1]] = chunks[2]
            end
        end
    end
    return result
end
local Request = {

    parse=function(request)
        local div = detectDivider(request);
        local chunks = StringTools.split(request, div.headerDivider, 1)
        local headers = StringTools.split(chunks[1], div.divider)
        local _, _, method, path, vars = string.find(headers[1], "([A-Z]+) (.+)?(.*) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(headers[1], "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(headers[1], "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        return {
            headers=processHeaders(headers),
            method=method,
            path=path,
            vars=vars,
            divider=div
            --data=chunks[2],
        }
    end
}

return Request
