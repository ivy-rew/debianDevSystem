#!/bin/bash

termDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat $termDir/dev-bash_aliases | tee -a $HOME/.bash_aliases
# route ZSH to bash-aliases
echo "source \$HOME/.bash_aliases" | tee -a $HOME/.zshrc 


cat <<EOF | tee -a $HOME/.bashrc | tee -a $HOME/.zshrc

# git-functs
source ${termDir}/gitOp.sh

EOF
