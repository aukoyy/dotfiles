# Network
alias localhost='ipconfig getifaddr $(route -n get default | awk "/interface/ { print \$2 }")'
alias ip="curl icanhazip.com"
alias ipv4="curl https://checkip.amazonaws.com"
alias mac="networksetup -listallhardwareports"
# ipconfig getifaddr en0 would also work

# DNS check for a domain
dns() {
  if [[ -z "$1" ]]; then
    echo "Usage: dns <domain>"
    return 1
  fi

  local domain="$1"

  for r in NS MX TXT CNAME; do
    echo "\n### $r"
    dig +short $r "$domain"
  done
  echo "\n### autodiscover"
  dig +short CNAME "autodiscover.$domain"
}
