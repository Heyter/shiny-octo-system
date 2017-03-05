import os
import re
json = """
{
"title"	: "The Fighting Few",
"type" : "gamemode",
"tags" : [ "fun", "realism" ],
"ignore" : [ "*.psd", "*.vcproj", "*.svn*" ]
}
"""

def processdir(file):
    print(file)
    for f in os.listdir('./'+file):
        print('=='+f)
        if os.path.isdir('./'+file+'/'+f):
            print('===dir')
            processdir(file+'/'+f)
        else:
            os.rename(file+'/'+f,file+'/'+f.lower())

if os.name == 'nt':
    pname = 'gmad.exe'
else:
    pname = 'gmad'

for file in os.listdir():
    if os.path.isdir(file):
        processdir(file)
        print(file)
        if not os.path.exists('{}/addon.json'.format(file)):
            
            print("dumb json")
            with open('{}/addon.json'.format(file),'w') as o:
                o.write(json)
        os.system('{} create -folder ".\{}" -out ".\{}.gma"'.format(pname,file,file))
        break
