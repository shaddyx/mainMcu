-- @disableUpload
local FileTools = require("FileTools")
EXPORT_ASSERT_TO_GLOBAL=true
lu = require('luaunit').LuaUnit

TestFileTools = {}
    function TestFileTools:setUp()
        self.file = os.tmpname ()
        print ('tmp file:'..self.file)
    end
    function TestFileTools:testWriteAndReadFile()
        local str = "aaaaaaaaaaaaaaaaa,bbbbbbbbbbbbbbbbbb"
        FileTools.filePutContents(self.file, str)
    end
    function TestFileTools:tearDown()
        if (FileTools.fileExists(self.file)) then
            os.remove(self.file)
        end
    end

os.exit(lu.run());