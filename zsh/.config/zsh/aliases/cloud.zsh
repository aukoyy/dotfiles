# AWS
alias awsid='aws sts get-caller-identity'
alias awsenv='env | grep -i aws'
alias awsme='export AWS_PROFILE=aukoyy'
alias awswork='unset AWS_PROFILE'

# Kubernetes
alias kc='kubectl'

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

