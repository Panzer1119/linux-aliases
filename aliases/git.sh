#!/bin/bash

# Git pull with stash
alias gspull='git stash && git pull && git stash pop'
alias grspull='git stash && git pull --recurse-submodules && git stash pop'
