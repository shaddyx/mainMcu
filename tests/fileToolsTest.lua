-- @disableUpload

require("tools/StringTools")
require("tools/FileTools")

TestFileTools = {}
    function TestFileTools:setUp()
        self.file = "./tmpFile"
        --print ('tmp file:'..self.file)
    end
    function TestFileTools:testWriteAndReadFile()
        local str = "aaaaaaaaaaaaaaaaa,bbbbbbbbbbbbbbbbbb"
        FileTools.filePutContents(self.file, str)
    end

    function TestFileTools:testFileExists()
        FileTools.filePutContents(self.file, "")
        lu.assertFalse(FileTools.fileExists(self.file.."___"))
        lu.assertTrue(FileTools.fileExists(self.file))
    end

    function TestFileTools:tearDown()
        if (FileTools.fileExists(self.file)) then
            os.remove(self.file)
        end
    end
