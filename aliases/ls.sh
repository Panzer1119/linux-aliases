#!/bin/bash

# List with eza
alias lsa='eza --long --header --group --all --color=always --group-directories-first --time-style long-iso --git --icons=always --classify=always --binary'
# List with sudo eza
alias slsa='sudo eza --long --header --group --all --color=always --group-directories-first --time-style long-iso --git --icons=always --classify=always --binary'

# List with watch and eza
alias wlsa='watch --color eza --long --header --group --all --color=always --group-directories-first --time-style long-iso --git --icons=always --classify=always --binary'
# List with watch and sudo eza
alias wslsa='watch --color sudo eza --long --header --group --all --color=always --group-directories-first --time-style long-iso --git --icons=always --classify=always --binary'
