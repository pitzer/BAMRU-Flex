#!/usr/bin/env bash

sudo RBENV_ROOT=$RBENV_ROOT su
whoami
export $RBENV_ROOT
echo $RBENV_ROOT
export PATH=$RBENV_ROOT:$PATH


