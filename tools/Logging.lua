local Logging = {}
local LEVELS={}
local BACK_LEVELS={}
LEVELS["TRACE"]=0
LEVELS["DEBUG"]=1
LEVELS["INFO"]=2
LEVELS["WARN"]=3
LEVELS["ERROR"]=4
for k, v in pairs(LEVELS) do
    BACK_LEVELS[v]=k
end
Logging.lvl=LEVELS.TRACE
function Logging.info(...)
    Logging.show(LEVELS.INFO, ...)
end
function Logging.debug(...)
    Logging.show(LEVELS.DEBUG, ...)
end
function Logging.error(...)
    Logging.show(LEVELS.ERROR, ...)
end
function Logging.warn(...)
    Logging.show(LEVELS.WARN, ...)
end
function Logging.getStrLvl(lvl)
    return BACK_LEVELS[lvl]
end

function Logging.show(lvl, a, b, c, d, e, f)
    if lvl < Logging.lvl then
        return
    end
    local t = {a, b, c, d, e, f }
    for k, v in pairs(t) do
        if type(v) == "table" then
            t[k] = "["..table.concat(v, ", ").."]"
        end
    end
    local str = table.concat(t, ", ")
    print (Logging.getStrLvl(lvl)..": "..str)
end
return Logging

