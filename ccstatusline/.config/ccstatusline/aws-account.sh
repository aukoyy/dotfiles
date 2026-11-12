#!/bin/bash
# The account comes from the inference-profile ARNs `cvp claude` exports, since
# the status line re-renders too often to afford an STS call.

input=$(cat)

account=$(
  printf '%s\n' \
    "${ANTHROPIC_MODEL:-}" \
    "${ANTHROPIC_DEFAULT_OPUS_MODEL:-}" \
    "${ANTHROPIC_DEFAULT_SONNET_MODEL:-}" \
    "${ANTHROPIC_DEFAULT_HAIKU_MODEL:-}" \
    "$(jq -r '.model.id // empty' <<<"$input" 2>/dev/null)" |
    grep -oE 'arn:aws[a-z-]*:bedrock:[a-z0-9-]*:[0-9]{12}:' |
    head -1 | cut -d: -f5
)

red=$'\e[1;31m'
yellow=$'\e[33m'
reset=$'\e[0m'

case "$account" in
  043180741939) echo "${yellow}AWS DEV/STG${reset}" ;;
  571580010132) echo "${red}AWS PRD${reset}" ;;
  485543188032) echo "${red}AWS PRD-US${reset}" ;;
  637423540658) echo "${red}AWS PRD-CA${reset}" ;;
  881017026848) echo "AWS BUILDTOOLS" ;;
  633056972712) echo "AWS MASTER" ;;
  302263063645) echo "AWS MARKETPLACE" ;;
  *) echo "AWS" ;;
esac
