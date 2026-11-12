#!/bin/bash
# Subscription usage numbers don't apply on Bedrock, so show the AWS account.
export PATH="$HOME/.local/share/mise/installs/node/lts/bin:$PATH"
if [[ -n "${CLAUDE_CODE_USE_BEDROCK:-}" ]]; then
  exec npx -y ccstatusline@latest --config "$HOME/.config/ccstatusline/bedrock.json"
fi
exec npx -y ccstatusline@latest
