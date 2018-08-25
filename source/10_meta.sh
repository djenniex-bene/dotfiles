# Functions of functions

function error() {
    local FUNCDESC='Echo arguments to STDERR'
    if [[ -z ${1} ]]; then
        usage "${FUCNAME} <message> [<more messages>]" ${FUNCDESC}
        return 1
    fi
    >&2 echo ${@}
}

function usage() {
    local FUNCDESC='Show instructions for using a function.
The first argument is a string describing how to use a function. There can be
multiple usage string arguments. All will be strung together and folded at the
terminal width.
The LAST argument is taken to be a string describing what the function does. It
is useful to keep this in a $FUNCDESC variable and pass it as the last argument
to usage().'

    USAGE="${1}"; shift
    if [[ -z "${1}" ]]; then
        usage "${FUNCNAME} <instruction> [<strings>] <description>" ${FUNCDESC}
        return 1
    fi
    MESSAGE="${@}"
    error Usage: ${USAGE}
    echo ${MESSAGE} | fold -s -w ${COLUMNS}
}
