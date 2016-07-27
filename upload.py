#!/usr/bin/python 
from subprocess import call
import os
def listDirRec(dir):
    res = []
    list = os.listdir(dir)
    for file in list:
        fullPath = os.path.join(dir, file)
        if os.path.isdir(fullPath):
            res += listDirRec(fullPath)
        else:
            res.append(fullPath)
    return res
def filterExt(files, ext):
    return filter(lambda file: file.split(".")[-1] == ext, files)
def readFile(name):
    file = open(name, "r")
    try:
        return file.read()
    finally:
        file.close()
def filterNotContains(files, contains):
    return filter(lambda file: not contains in readFile(file), files)

def upload(file):
    env=os.environ.copy()
    print "uploading: " + file
    call(["mcuUpload " + file], shell=True, env=env)

res = listDirRec("./")
res = filterExt(res, "lua")
res = filterNotContains(res, "@disableUpload")

for file in res:
    upload(file)
    
#for file in res:
#upload("./init.lua")   