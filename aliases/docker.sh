#!/bin/bash

# Docker compose
alias dc='docker compose'

# Docker compose pull
alias dcp='docker compose pull'

# Docker compose up
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcudlf='docker compose up -d && docker compose logs -f'

# Docker compose logs
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'

# Docker compose down
alias dcd='docker compose down'

# Docker compose restart
alias dcr='docker compose restart'
alias dcrlf='docker compose restart && docker compose logs -f'
