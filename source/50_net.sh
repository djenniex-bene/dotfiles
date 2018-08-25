# IP addresses
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Ping the specified server (or the default 8.8.8.8) and say "ping"
# through the speaker every time a ping is successful. Based on an
# idea from @gnarf.
function pingtest() {
  local c
  for c in say spd-say; do [[ "$(which $c)" ]] && break; done
  ping ${1:-8.8.8.8} | perl -pe '/bytes from/ && `'$c' ping`'
}

function tunnel-port() {
    local FUNCDESC="Tunnel a port locally via a ssh box."
    if [[ ${#} -lt 3 ]]; then
        error "${FUNCNAME}: must supply port, ssh-host and a target."
        usage "${FUNCNAME} <port> <ssh-host>" ${FUNCDESC}
        return 1
    fi
    local port="${1}"
    local jumpbox="${2}"

    ssh -F ${HOME}/.ssh/config -L ${port}:localhost:${port} ${jumpbox}
}

# Common Tunnels
alias tunnel-https='tunnel-port 443'
alias tunnel-http='tunnel-port 80'
alias tunnel-db='tunnel-port 5432'
alias tunnel-solr='tunnel-port 8983'
alias tunnel-exhibitor='tunnel-port 8181'
