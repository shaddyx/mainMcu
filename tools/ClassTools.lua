if (ClassTools == nil) then
    ClassTools = {}
    function ClassTools.create(mtable)
        cls = {}
        cls.__init = cls
        cls.new = function(...)
            local self = setmetatable(mtable, cls)
            if (self.constructor ~= nil) then
                self:constructor(...)
            end
            return self
        end
        return cls
    end
end