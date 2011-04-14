#!/usr/bin/python
import re, os

def getpwd(X):
    s = "%s: (.*)" % X
    p = re.compile(s)
    authinfo = os.popen("gpg -q --use-agent --batch -d ~/.shellsecrets.gpg").read()
    #authinfo = os.popen("gpg -q -d ~/.authinfo.gpg").read()
    return p.search(authinfo).group(1)
