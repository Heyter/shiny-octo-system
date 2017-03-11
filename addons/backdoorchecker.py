import os
import codecs
import re
susp = ['STEAM_0','pcall','RunString',"HTTP","HTTPS","superadmin","admin","RunConsoleCommand",
        "RunStr","post","XJX3LNWQO1S58PJ1fza0","ConsoleCommand","CompileString","RunStringEx",
        "addUser","removeGroup","82, 117, 110, 83, 116, 114, 105, 110, 103","gameserverenforcer"]
suspr = ['\d{17}','ulx log.* 0']

supas = ""

def print2(*args):
    global supas
    for k in args:
        supas+=k+' '
    supas+='\n'
    print(*args)

def writelog():
    with codecs.open("log.lua",'w',"utf_8_sig") as i:
        i.write(supas)

def processfile(file):
    #print(file)
    with codecs.open(file,'r',"utf_8_sig") as i:
        text = i.read()
        for x in susp:
            if x in text:
                print2("ATENTION-",x,file)
                locus = re.findall('.{0,10}'+x+'.{0,30}',text,re.U)
                for loc in locus:
                    print2('\t'+loc)
                print2('\n')
                    
        for x in suspr:
            temp = re.findall(x,text,re.U)
            if len(temp) > 0:
                print2("ATENTION-",x,file)
                print2("\t",''.join(temp))
                print2('\n')
            
def processdir(file):
    for f in os.listdir(file):
        if os.path.isdir(file+'/'+f):
            processdir(file+'/'+f)
        if f[-4:] == ".lua":
            try:
                processfile(file+'/'+f)
            except Exception as e:
                print(e,file+'/'+f)
                pass
print("Write path to working dir or press enter ti use current dir")
dr = input()
if dr == "":
    dr = os.getcwd()
    dr = dr.replace('\\','/')
print(dr)
processdir(dr)
writelog()
