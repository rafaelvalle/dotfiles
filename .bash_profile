# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------
if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi


#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#  This works for me - your mileage may vary. . . .
#  The problem is that different types of terminals give
#+ different answers to 'who am i' (rxvt in particular can be
#+ troublesome) - however this code seems to work in a majority
#+ of cases.
#--------------------------------------------------------------

function get_xserver ()
{
    case $TERM in
        xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            #  I_AM=$(who am i)
            #  SERVER=${I_AM#*(}
            #  SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
            aterm | rxvt)
            # Find some code that works here. ...
            ;;
    esac
}

export DISPLAY

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

#EXPORTS
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts    # Put a list of remote hosts in ~/.hosts
export SVN_EDITOR=vim

#ALIASES
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'


alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -GF'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll='ls -alF -h'
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


# Alias for folders
alias repos='cd /Volumes/liferaid/Repositories/'
alias analytics='cd ~/GoogleDrive/:AudioAnalytics/'
alias media='cd /Media'
alias spec='cd /Volumes/liferaid/Repositories/Impro/Experiments/specMining'
alias mpg='cd /Users/rafaelvalle/Desktop/research/music_pattern_graphs/'
alias mdi='cd /Users/rafaelvalle/Desktop/research/MDI'
alias nnc='cd /Users/rafaelvalle/Desktop/research/neural_network_control_improvisation'
alias mseg='cd /Users/rafaelvalle/Desktop/research/music_segmentation'
alias mkt='cd /Users/rafaelvalle/Desktop/research/metaknobtwiddler'
alias abroa='cd /Users/rafaelvalle/Desktop/research/abroa'

#############
#  EXPORTS  #
#############
export TKSRC=/usr/local/bin

# Architecture flags
export ARCHFLAGS="-arch x86_64"

# Parallel processing
export NUMPROCS=4

# Ensure user-installed binaries take precedence
# export PYTHONPATH=/usr/local/lib/python2.7/site-packages # python3 compat
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin

# LLVM from brew
export LLVM_CONFIG=/usr/local/opt/llvm37/bin/llvm-config-3.7

# ACESS KEYS
export AWS_ACCESS_KEY_ID=AKIAJTOFT4XUUP6GOW5Q
export AWS_SECRET_ACCESS_KEY=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
export DIGITAL7_API_KEY=7dyjctbspfrd

#################
#  EXECUTABLES  #
#################
alias jnb='jupyter notebook'
alias ipy='ipython'
alias py='python'

compiletex() {
  latex $1.tex
  bibtex $1
  pdflatex $1.tex
}
alias comptex=compiletex

compileptex() {
  pdflatex $1.tex
  bibtex $1
  pdflatex $1.tex
}
alias compptex=compileptex

# GITHUB Functions
function gc() {
  git commit -m "$*"
}

function ga() {
  git add $*
}

function gt() {
  git checkout $*
}

function gs() {
  git status $*
}

function gd() {
  git diff $*
}

function gp() {
  git push
}

function gl() {
  git pull
}


# SSH SHORTCUTS
function muleboard() {
    ssh -N -f -L localhost:16006:localhost:6006 rafaelvalle@128.32.122.73
}

function gmula() {
    ssh -Y rafaelvalle@128.32.122.73
}

function gohome() {
    ssh rafaelvalle_mini@192.168.0.103
}

function gocnmat() {
    ssh rafaelvalle@128.32.122.155
}

function mmula() {
    sshfs -o cache=no rafaelvalle@128.32.122.73:/home/rafaelvalle/ ~/Desktop/steampunk/ -ovolname=steampunk
}

function mmdata() {
    sshfs -o cache=no rafaelvalle@128.32.122.73:/media/steampunkhd/rafaelvalle/datasets/ ~/Desktop/muledata/ -ovolname=mdata 
}

function umula() {
    umount ~/Desktop/steampunk
}

function mdoshi() {
    sshfs -o cache=no rafaelvalle@128.32.122.73:/home/apdoshi/ ~/Desktop/apdoshi/ -ovolname=apdoshi
}

function udoshi() {
    umount ~/Desktop/apdoshi
}

function umuledata() {
    umount ~/Desktop/muledata
}

function rmula() {
    umula
    mmula
}

. /Users/rafaelvalle/torch/install/bin/torch-activate
