#!/bin/bash
# Prints the current kube context, with EKS ARNs shortened to the cluster name
# (PRD-US-..., DEV-EU-...) like the Starship prompt. Prints nothing if unset.

context=$(kubectl config current-context 2>/dev/null)
[[ -z "$context" ]] && exit 0
echo "󱃾 ${context##*:cluster/}"
