
export OMD_SITE=###SITE###
export OMD_ROOT=###ROOT###

PATH=~/local/bin:~/bin:~/local/lib/perl5/bin:$PATH
export LD_LIBRARY_PATH=$OMD_ROOT/local/lib:$OMD_ROOT/lib

# enable local perl env
export PERL5LIB="$OMD_ROOT/local/lib/perl5/lib/perl5:$OMD_ROOT/lib/perl5/lib/perl5:$PERL5LIB"
export PATH="$OMD_ROOT/lib/perl5/bin:$PATH"
export MODULEBUILDRC="$OMD_ROOT/.modulebuildrc"
export PERL_MM_OPT=INSTALL_BASE="$OMD_ROOT/local/lib/perl5/"
export MANPATH="$OMD_ROOT/share/man:$MANPATH"
export PYTHONPATH="$OMD_ROOT/lib/python:$OMD_ROOT/local/lib/python"
export MAILRC="$OMD_ROOT/etc/mail.rc"


if [ -f ~/etc/environment ]
then
    eval $(egrep -v '^[[:space:]]*(#|$)' < ~/etc/environment | sed 's/^/export /')
fi

# Only load bashrc when in a bash shell and not loaded yet.
# The load once is ensured by the variable $BASHRC.
if [ "$BASH" -a -s ~/.bashrc -a -z "$BASHRC" ]; then
    . ~/.bashrc
fi

function init-hook() {
  # Takes 3 parameters
  # 1. Name of the init-script (can be the full path name, we will only use the file part)
  # 2. The command the init-script was called with (start, stop, reload,..)
  # 3. A fixed string, either "pre" os "post"
  hook=$(printf "###ROOT###/etc/init-hooks.d/%s-%s-%s" ${1##*/} $2 $3)
  test -x $hook && $hook ${1##*/} $2 $3
}
