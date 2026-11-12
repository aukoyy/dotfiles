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

# Labels the account Claude's Bedrock calls go through, not the one you work in,
# hence the Claude icon, "Bedrock" and no warning colors.
case "$account" in
  043180741939) label="DEV/STG" ;;
  571580010132) label="PRD" ;;
  485543188032) label="PRD-US" ;;
  637423540658) label="PRD-CA" ;;
  881017026848) label="BUILDTOOLS" ;;
  633056972712) label="MASTER" ;;
  302263063645) label="MARKETPLACE" ;;
  *) label="" ;;
esac

claude=$'\e[38;2;215;119;87m'
reset=$'\e[0m'

echo "${claude} Bedrock${label:+ $label}${reset}"
