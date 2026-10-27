alias cpg='cat package.json | grep'

# Decoder for JWT tokens
# > jwt <jwt-token>
jwt() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

# NPM cheatsheet function - essential npm commands
function npmc() {
  echo ""
  echo "📦 NPM Essential Commands:"
  echo ""
  echo "🔍 Check:"
  echo "  1. npm outdated           - Check for outdated packages"
  echo "  2. npx npm-check-updates  - Check for updates (detailed)"
  echo "  3. npm list --depth=0     - List installed packages"
  echo "  4. npx depcheck           - Check for unused packages"
  echo ""
  echo "⚡ Actions:"
  echo "  5. ncu -u && npm install  - Update package.json and install"
  echo ""

  read "choice?Enter number to run command (or press Enter to exit): "

  # Helper function to check if we're in a Node.js project
  local check_project() {
    if [[ ! -f "package.json" ]]; then
      echo ""
      echo "⚠️  No package.json found in current directory"
      return 0
    fi
  }

  case $choice in
    1) echo ""; check_project && npm outdated ;;
    2) echo ""; check_project && npx npm-check-updates ;;
    3) echo ""; npm list --depth=0 ;;
    4) echo ""; check_project && npx depcheck ;;
    5) echo ""; check_project && npx npm-check-updates -u && npm install ;;
    *) echo ""; echo "Exiting..." ;;
  esac
}

# shortcut for the versions function
alias v='versions'

# Set a function that can print the current version of some packages
function versions() {
  echo "Using mise for Python and Node versions"
  echo "Python version:"
  python -V
  echo ""
  echo "Node version:"
  node -v
  echo "NPM version:"
  npm -v
}

# Productivity
alias digiget='npm --prefix /Users/aukoyy/code/projects/digiget run show'
