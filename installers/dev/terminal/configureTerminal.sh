#!/bin/bash

cat $DIR/dev-bash_aliases | tee -a $HOME/.bash_aliases

termDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat <<EOF | tee -a $HOME/.bashrc

# git-functs
source ${termDir}/gitOp.sh

EOF