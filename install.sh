#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "${1}" >/dev/null 2>&1
}

# Main function
main() {
  # Repository URL
  local repo_url="https://github.com/Panzer1119/linux-aliases.git"
  local repo_dir="${HOME}/repositories/git/linux-aliases"

  # Clone the repository if it doesn't exist
  if [ ! -d "${repo_dir}" ]; then
    mkdir -p "${repo_dir}"
    if command_exists git; then
      git clone "${repo_url}" "${repo_dir}"
    else
      echo "git is not installed. Please install git to use this script."
      return
    fi
  fi

  # Execute run.sh script from the cloned repository inside ~/.bashrc, but only if not already in .bashrc
  if ! grep -q "source ${repo_dir}/run.sh" "${HOME}/.bashrc"; then
    echo "source ${repo_dir}/run.sh" >>"${HOME}/.bashrc"
  fi

  # Source all alias files in the repository, so the aliases are still usable after this install script exits
  local file
  for file in "${repo_dir}"/*; do
    [ -f "${file}" ] && source "${file}"
  done
}

# Run the main function
main
