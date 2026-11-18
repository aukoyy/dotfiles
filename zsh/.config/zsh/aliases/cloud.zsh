# AWS
alias awsid='aws sts get-caller-identity'
alias awsenv='env | grep -i aws'
alias awsme='export AWS_PROFILE=aukoyy'
alias awswork='unset AWS_PROFILE'

typeset -gA AWS_ACCOUNT_ALIASES=(
  402327200937 auk
  881017026848 bld
  633056972712 mst
  302263063645 mkt
  043180741939 dev
  571580010132 prd
  485543188032 pus
  637423540658 pca
)

_aws_ini_get() {
  local file=$1 section=$2 key=$3 line
  local -i in_section=0
  [[ -r $file ]] || return 1
  for line in "${(@f)$(<$file)}"; do
    if [[ $line == \[*\] ]]; then
      [[ $line == "[$section]" ]] && in_section=1 || in_section=0
    elif (( in_section )) && [[ $line =~ "^[[:space:]]*${key}[[:space:]]*=[[:space:]]*([^[:space:]]*)" ]]; then
      REPLY=$match[1]
      return 0
    fi
  done
  return 1
}

# Access key IDs embed the account ID: base32-decode the part after the
# 4-char prefix and the account sits in bits 1-39 of the first 48 bits.
_aws_key_account() {
  local key=$1 alphabet=ABCDEFGHIJKLMNOPQRSTUVWXYZ234567 c
  local -i bits=0 i
  local -i 10 account
  (( ${#key} >= 14 )) || return 1
  for c in ${(s::)key[5,14]}; do
    i=${alphabet[(i)$c]}
    (( i <= 32 )) || return 1
    (( bits = (bits << 5) | (i - 1) ))
  done
  (( account = ((bits >> 2) & 0x7fffffffff80) >> 7 ))
  REPLY=${(l:12::0:)account}
}

_aws_arn_account() {
  [[ $1 =~ ':([0-9]{12}):' ]] && REPLY=$match[1]
}

_aws_prompt_update() {
  local profile=${AWS_PROFILE:-${AWS_DEFAULT_PROFILE:-default}}
  local config=${AWS_CONFIG_FILE:-$HOME/.aws/config}
  local creds=${AWS_SHARED_CREDENTIALS_FILE:-$HOME/.aws/credentials}
  local config_section="profile $profile" account expires now REPLY
  [[ $profile == default ]] && config_section=default

  if [[ -n $AWS_ACCESS_KEY_ID ]]; then
    _aws_key_account $AWS_ACCESS_KEY_ID && account=$REPLY
    expires=$AWS_CREDENTIAL_EXPIRATION
  elif _aws_ini_get $config $config_section role_arn && _aws_arn_account $REPLY; then
    account=$REPLY
  elif _aws_ini_get $creds $profile aws_access_key_id && _aws_key_account $REPLY; then
    account=$REPLY
    _aws_ini_get $creds $profile x_security_token_expires && expires=$REPLY
  elif _aws_ini_get $config $config_section sso_account_id; then
    account=$REPLY
  elif _aws_ini_get $config $config_section login_session && _aws_arn_account $REPLY; then
    account=$REPLY
  fi

  if [[ -z $account ]]; then
    unset PROMPT_AWS_ACCOUNT
    return
  fi

  local label=${AWS_ACCOUNT_ALIASES[$account]}
  label=${label:+$label-${account[-4,-1]}}
  if [[ -n $expires ]]; then
    TZ=UTC0 strftime -s now '%Y-%m-%dT%H:%M:%S' $EPOCHSECONDS
    [[ ${expires[1,19]} < $now ]] && label+=' (expired)'
  fi
  export PROMPT_AWS_ACCOUNT=${label:-$account}
}

zmodload zsh/datetime
autoload -Uz add-zsh-hook
add-zsh-hook precmd _aws_prompt_update

# Kubernetes
alias kc='kubectl'

# Lima
alias lc='limactl'

# alias eksnodes="/Users/aukoyy/code/flowcase/eks-node-viewer/eks-node-viewer --resources=cpu,memory --extra-labels=topology.kubernetes.io/zone,karpenter.sh/nodepool"
alias eksnodes="/Users/aukoyy/.local/bin/eks-node-viewer --resources=cpu,memory --extra-labels=topology.kubernetes.io/zone,karpenter.sh/nodepool"

# helper text for backing up on AWS S3
function backup() {
  echo ""
  echo "AWS backup instructions:"
  echo "Download folder: aws s3 cp S3 <bucket URI> <local dir> --recursive"
  echo "Backup folder: ??"
  echo ""
}

