#!/usr/bin/python
# Author: Marcin Szamotulski
# Date: 23 IV 2011
# This file is a part of AutomaticTexPlugin plugin for Vim.
# It is distributed under General Public Licence v3 or higher.

import shutil, os.path, re, optparse, subprocess, traceback
from optparse import OptionParser
import os
from os import getcwd
from collections import deque


usage   = "usage: %prog [options]"
parser  = OptionParser(usage=usage)

parser.add_option("--texfile",          dest="texfile"                                                  )
parser.add_option("--cmd",              dest="cmd",             default="pdflatex"                      )
parser.add_option("--bibcmd",           dest="bibcmd",          default="bibtex"                        )
parser.add_option("--tex-options",      dest="tex_options",     default=""                              )
parser.add_option("--outdir",           dest="outdir"                                                   )
parser.add_option("--tempdir",           dest="tempdir")
parser.add_option("--progname",         dest="progname",        default="gvim"                          )
parser.add_option("--servername",       dest="servername")
# This is not yet used.
parser.add_option("--force",            dest="force",           default=False,          action="store_true")
parser.add_option("--env",              dest="env",             default=""                              )


(options, args) = parser.parse_args()

debugfile=os.path.join(options.tempdir, "makelatex.log")
debug_file=open(debugfile, "w")

texfile = options.texfile
basename = os.path.splitext(os.path.basename(texfile))[0]
texfile_dir = os.path.dirname(texfile)
logfile = basename+".log"
auxfile = basename+".aux"
bibfile = basename+".bbl"
idxfile = basename+".idx"
indfile = basename+".ind"
tocfile = basename+".toc"
loffile = basename+".lof"
lotfile = basename+".lot"
thmfile = basename+".thm"

# FILTER:
def nonempty(str):
	if re.match('\s*$', str):
            return False
	else:
            return True
servername      = options.servername
debug_file.write("servername="+servername+"\n")
progname        = options.progname
debug_file.write("progname="+progname+"\n")
cmd		= options.cmd
debug_file.write("cmd="+cmd+"\n")
tex_options	= options.tex_options
debug_file.write("tex_options="+tex_options+"\n")
bibcmd		= options.bibcmd
debug_file.write("bibcmd="+bibcmd+"\n")
biber=False
if re.search(bibcmd, '^\s*biber'):
    biber=True

tex_options	= options.tex_options
if re.match('\s*$', tex_options):
    tex_options_list=[]
else:
    if re.search('\s', tex_options):
        tex_options_list=' '.split(tex_options)
        tex_options_list=list(filter(nonempty,tex_options_list))
    else:
        tex_options_list=[tex_options]
debug_file.write("tex_options_list="+str(tex_options_list)+"\n")

outdir		= options.outdir
debug_file.write("outdir="+outdir+"\n")
force		= options.force
debug_file.write("force="+str(force)+"\n")

def mysplit(string):
        return re.split('\s*=\s*', string)
if len(options.env)>0:
    env = list(map(mysplit, list(filter(nonempty, re.split('\s*;\s*',options.env)))))
else:
    env = []


# RUN NUMBER
run   = 0
# BOUND (do not run pdflatex more than this) 
# echoerr in Vim if bound is reached.
bound = 7

# FUNCTIONS

def vim_remote_expr(servername, expr):
# Send <expr> to vim server,

# expr must be well quoted:
#       vim_remote_expr('GVIM', "atplib#CatchStatus()")
# (this is the only way it works)
#     print("VIM_REMOTE_EXPR "+str(expr))
    cmd=[progname, '--servername', servername, '--remote-expr', expr]
    devnull=open(os.devnull, "w+")
    subprocess.Popen(cmd, stdout=devnull, stderr=subprocess.STDOUT).wait()
    devnull.close()

def latex_progress_bar(cmd):
# Run latex and send data for progress bar,

    debug_file.write("RUN "+str(run)+" cmd"+str(cmd)+"\n")

    child = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    pid   = child.pid

    vim_remote_expr(servername, "atplib#LatexPID("+str(pid)+")")
    stack = deque([])
    while True:
        out = child.stdout.read(1).decode()
        if out == '' and child.poll() != None:
            break
        if out != '':
            stack.append(out)

            if len(stack)>10:
                stack.popleft()
            match = re.match('\[(\n?\d(\n|\d)*)({|\])',''.join(stack))
            if match:
                vim_remote_expr(servername, "atplib#ProgressBar("+match.group(1)[match.start():match.end()]+","+str(pid)+")")
    child.wait()
    vim_remote_expr(servername, "atplib#ProgressBar('end',"+str(pid)+")")
    vim_remote_expr(servername, "atplib#PIDsRunning(\"b:atp_LatexPIDs\")")
    return child


try:
    cwd = getcwd()
    os.chdir(texfile_dir)

# Note always run first time.
# this ensures that the aux, ... files are uptodate.

# WE RUN FOR THE FIRST TIME:
# Set Environment:
    if len(env) > 0:
        for var in env:
            os.putenv(var[0], var[1])

    latex=latex_progress_bar([cmd, '-interaction=nonstopmode', '-output-directory='+outdir]+tex_options_list+[texfile])
    run  += 1
    latex.wait()
    vim_remote_expr(servername, "atplib#TexReturnCode('"+str(latex.returncode)+"')")

# AFTER FIRST TIME LOG FILE SHOULD EXISTS:
    if os.path.isfile(logfile):

        need_runs = 1

        log_file  = open(logfile, "r")
        log       = log_file.read()
        log_file.close()
# undefined references|Citations undefined|Label(s) may have changed|Writing index file
#Note: this is used only in the second run:
#     log_list=re.findall('(u\n?n\n?d\n?e\n?f\n?i\n?n\n?e\n?d\s+r\n?e\n?f\n?e\n?r\n?e\n?n\n?c\n?e\n?s)|(C\n?i\n?t\n?a\n?t\n?i\n?o\n?n\n?s\s+u\n?n\n?d\n?e\n?f\n?i\n?n\n?e\n?d)|(L\n?a\n?b\n?e\n?l\(s\)\s+m\n?a\n?y\s+h\n?a\n?v\n?e\s+c\n?h\n?a\n?n\n?g\n?e\n?d)|(W\n?r\n?i\n?t\n?i\n?n\n?g\s+i\n?n\n?d\n?e\n?x\s+f\n?i\n?l\n?e)',log)
        log_list=re.findall('(undefined references)|(Citations undefined)|(Label\(s\) may have changed)|(Writing index file)',log)
        citations       =False
        labels          =False
        makeidx         =False
        for el in log_list:
            if el[0] != '' or el[1] != '':
                citations       =True
                if not biber:
                    need_runs   =1
            if el[2] != '':
                labels          =True
            if el[3] != '':
                makeidx         =True
                need_runs       =2

        debug_file.write("citations="+str(citations)+"\n")
        debug_file.write("labels="+str(labels)+"\n")
        debug_file.write("makeidx="+str(makeidx)+"\n")

# Scan for openout files to know if we are makeing: toc, lot, lof, thm
        openout_list=re.findall("\\\\openout\d+\s*=\s*`([^']*)'",log)
        toc     =False
        lot     =False
        lof     =False
        thm     =False
        for el in openout_list:
            if re.search('\.toc$',el):
                toc=True
                need_runs=2
            if re.search('\.lof$',el):
                lof=True
                need_runs=2
            if re.search('\.lot$',el):
                lot=True
                need_runs=2
            if re.search('\.thm$',el):
                thm=True
                need_runs=2

        debug_file.write("A0 need_runs="+str(need_runs)+"\n")

# Aux file should be readable (we always run for the first time)
#     auxfile_readable = os.path.isfile(auxfile)
        idxfile_readable = os.path.isfile(idxfile)
        tocfile_readable = os.path.isfile(tocfile)
        loffile_readable = os.path.isfile(loffile)
        lotfile_readable = os.path.isfile(lotfile)
        thmfile_readable = os.path.isfile(thmfile)

        aux_file=open(auxfile, "r")
        aux=aux_file.read()
        aux_file.close()
        bibtex=re.search('\\\\bibdata\s*{', aux)
        if not bibtex:
# Then search for biblatex package.
            for line in open(texfile):
                if re.match('[^%]*\\\\usepackage\s*(\[[^]]*\])?\s*{(\w\|,)*biblatex',line):
                    bibtex=True
                    break
                elif re.search('\\\\begin\s*{\s*document\s*}',line):
                    break
        debug_file.write("BIBTEX="+str(bibtex)+"\n")

# I have to take the second condtion (this is the first one):
        condition = citations or labels or makeidx or run <= need_runs
        debug_file.write(str(run)+"condition="+str(condition)+"\n")

# HERE IS THE MAIN LOOP:
# I guess some of the code done above have to be put inside the loop.
# Maybe it would be nice to make functions from some parts of the code.
        while condition:
            if run == 1:
# BIBTEX
                if bibtex:
                    bibtex=False
                    if re.search(bibcmd, '^\s*biber'):
                        auxfile = basename
                    bibtex=subprocess.Popen([bibcmd, auxfile], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                    vim_remote_expr(servername, "atplib#BibtexPID('"+str(bibtex.pid)+"')")
                    vim_remote_expr(servername, "atplib#redrawstatus()")
                    bibtex.wait()
                    vim_remote_expr(servername, "atplib#PIDsRunning(\"b:atp_BibtexPIDs\")")
                    bibtex_output=re.sub('"', '\\"', bibtex.stdout.read().decode())
                    vim_remote_expr(servername, "atplib#BibtexReturnCode('"+str(bibtex.returncode)+"',\""+str(bibtex_output)+"\")")
# MAKEINDEX
                if makeidx:
                    makeidx=False
                    index=subprocess.Popen(['makeindex', idxfile], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                    vim_remote_expr(servername, "atplib#MakeindexPID('"+str(index.pid)+"')")
                    vim_remote_expr(servername, "atplib#redrawstatus()")
                    index.wait()
                    vim_remote_expr(servername, "atplib#PIDsRunning(\"b:atp_MakeindexPIDs\")")
                    index_returncode=index.returncode

# LATEX
            latex=latex_progress_bar([cmd, '-interaction=nonstopmode', '-output-directory='+outdir]+tex_options_list+[texfile])
            run  += 1
            latex.wait()
            vim_remote_expr(servername, "atplib#CatchStatus('"+str(latex.returncode)+"')")

#CONDITION
            log_file=open(logfile, "r")
            log=log_file.read()
            log_file.close()

# Citations undefined|Label(s) may have changed
#         log_list=re.findall('(C\n?i\n?t\n?a\n?t\n?i\n?o\n?n\n?s\s+u\n?n\n?d\n?e\n?f\n?i\n?n\n?e\n?d)|(L\n?a\n?b\n?e\n?l\(s\)\s+m\n?a\n?y\s+h\n?a\n?v\n?e\s+c\n?h\n?a\n?n\n?g\n?e\n?d)',log)
            log_list=re.findall('(undefined references)|(Citations undefined)|(Label\(s\) may have changed)|(Writing index file)',log)
#         citations_pre   =citations
            citations       =False
            labels          =False
#             makeidx         =False
            for el in log_list:
                if el[0] != '' or el[1] != '':
                    citations       =True
                if el[2] != '':
                    labels          =True
#             if el[2] != '':
#                 makeidx         =True
            debug_file.write(str(run)+"citations="+str(citations)+"\n")
#         debug_file.write(str(run)+"citations_pre="+str(citations_pre)+"\n")
            debug_file.write(str(run)+"labels="+str(labels)+"\n")
            debug_file.write(str(run)+"makeidx="+str(makeidx)+"\n")

            debug_file.write(str(run)+"need_runs="+str(need_runs)+"\n")

            condition = ( (citations and run <= need_runs) or labels or makeidx or run <= need_runs ) and run <= bound
            debug_file.write(str(run)+"condition="+str(condition)+"\n")
# else:
# THERE IS NO LOG FILE AFTER FIRST TIME: exit with error.
except Exception:
    error_str=re.sub("'", "''",re.sub('"', '\\"', traceback.format_exc()))
    traceback.print_exc(None, debug_file)
    vim_remote_expr(servername, "atplib#Echo(\"[ATP:] error in makelatex.py, catched python exception:\n"+error_str+"[ATP info:] this error message is recorded in makelatex.py.log under g:atp_TempDir\",'echo','ErrorMsg')")

os.chdir(cwd)
debug_file.close()
