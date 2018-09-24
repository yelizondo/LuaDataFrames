
def writeFile(pPath, pContent):
    file = open(pPath,'w')
    file.write(pContent)
    file.close()

def readFile(pPath, pMode):
    file = open(pPath, pMode)
    content = file.read()
    file.close()
    return content
