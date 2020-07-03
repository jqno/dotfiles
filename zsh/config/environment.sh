# PATH
export PATH=/usr/local/sbin:/sbin:~/bin:~/scripts:~/Library/Application\ Support/Coursier/bin:~/.cargo/bin:~/Library/Python/3.7/bin:/usr/local/opt/ruby/bin:$PATH

# Default editor
export EDITOR=vim

# Required for GPG
export GPG_TTY=$(tty)

# Make sure UTF-8 is used in Vim
export LC_ALL="en_US.UTF-8"

# FZF configuration
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-a:select-all"

# Initialize JAVA_HOME for use in `.zprofile` where `setjdk` is not available
export JAVA_HOME=`/usr/libexec/java_home -v 11`

