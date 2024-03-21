#!/bin/bash

termDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

devAliases(){
  cat $termDir/dev-bash_aliases | tee -a $HOME/.bash_aliases
  # route ZSH to bash-aliases
  echo "source \$HOME/.bash_aliases" | tee -a $HOME/.zshrc 
}

sourceGit(){
  cat <<EOF | tee -a $HOME/.bashrc | tee -a $HOME/.zshrc

# git-functs
source ${termDir}/gitOp.sh

EOF
}

devBinaries(){
  devBin=$(realpath ${termDir}/../../../bin)
  cat <<EOF | tee -a $HOME/.profile

# include debianDevSystem
if [ -d "${devBin}" ]; then
      PATH="${devBin}:\$PATH"
fi
EOF
}

devAliases
sourceGit
devBinaries
