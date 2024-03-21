#!/bin/bash

cat $DIR/dev-bashrc | tee -a $HOME/.bashrc
cat $DIR/dev-bash_aliases | tee -a $HOME/.bash_aliases
