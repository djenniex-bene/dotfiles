# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias grep='grep --color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

_complete_ssh_hosts ()
{
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
    cut -f 1 -d ' ' | \
    sed -e s/,.*//g | \
    grep -v ^# | \
    uniq | \
    grep -v "\[" ;
    cat ~/.ssh/config | \
    grep "^Host " | \
    awk '{print $2}'
  `
  COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
  return 0
}
complete -F _complete_ssh_hosts ssh

# Disable ansible cows }:]
export ANSIBLE_NOCOWS=1

# "fuck"
if [[ "$(which thefuck)" ]]; then
  eval $(thefuck --alias)
fi

createrepo () {
    local tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --rm \
        --interactive \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        -v $(pwd):/repo  \
        createrepo "$@"
}

alias tfapply="terraform apply ~/code/Ops/tfplans/\$(ls -w1 -t ~/code/Ops/tfplans | head -1)"

tfplan () {
  terraform plan -out ~/code/Ops/tfplans/$(basename $(pwd))_$(date +%F_%H_%M_%S).tfplan "$@"
}
