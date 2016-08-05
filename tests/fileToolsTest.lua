-- @disableUpload

local FileTools = require("tools/FileTools")
local StringTools = require("tools/StringTools")
lu = require('luaunit')

local TestFileTools = {}
    function TestFileTools:setUp()
        FileTools.file = "./tmpFile"
        --print ('tmp file:'..self.file)
    end
    function TestFileTools:testWriteAndReadFile()
        local str = "aaaaaaaaaaaaaaaaa,bbbbbbbbbbbbbbbbbb"
        FileTools.filePutContents(FileTools.file, str)
    end

    function TestFileTools:testFileExists()
        FileTools.filePutContents(FileTools.file, "")
        lu.assertFalse(FileTools.fileExists(FileTools.file.."___"))
        lu.assertTrue(FileTools.fileExists(FileTools.file))
    end

    function TestFileTools:tearDown()
        if (FileTools.fileExists(FileTools.file)) then
            os.remove(FileTools.file)
        end
    end
return TestFileTools