#!/usr/bin/python
import os
import glob
dir = "./"
def listRecursive(dir):
    res = []
    files = os.listdir(dir)
    for file in files:
        fullPath = os.path.join(dir, file)
        res.append(fullPath)
        if os.path.isdir(fullPath):
            res += listRecursive(fullPath)
    return res

def findExt(dir, ext):
    return filter(lambda file: file.split(".")[-1] == ext, listRecursive(dir))

def file_get_contents(filename):
    fp = open(filename, "r")
    content = fp.read()
    fp.close()
    return content

filesToUpload = filter(lambda file: not "@disableUpload" in file_get_contents(file),findExt(dir, "lua"))
print filesToUpload

    