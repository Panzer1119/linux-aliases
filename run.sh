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

  # Source all alias files in the repository
  local file
  for file in "${repo_dir}/aliases"/*; do
      [ -f "${file}" ] && source "${file}"
  done

  # Function to fetch the repository updates and notify the user
  fetch_repo_updates() {
    local repo_base_name
    local tty
    if [ -d "${repo_dir}/.git" ]; then
      # Fetch the latest changes from the remote repository
      (cd "${repo_dir}" && git fetch --quiet)

      # Check if there are new commits
      local sha_local
      local sha_remote
      sha_local=$(cd "${repo_dir}" && git rev-parse @)
      sha_remote=$(cd "${repo_dir}" && git rev-parse @\{u\})

      # Notify the user if there are new commits
      if [ "${sha_local}" != "${sha_remote}" ]; then
        repo_base_name=$(basename "${repo_dir}")
        for tty in $(who | awk '{print $2}'); do
          # Send the notification to the user's terminal (but ignore errors if the terminal is not available)
          echo "Updates are available for ${repo_base_name}. Please run 'git pull' in '${repo_dir}' manually to apply changes." >"/dev/${tty}" 2>/dev/null || true
        done
      fi
    fi
  }

  # Run the fetch in the background
  (fetch_repo_updates &) & disown
}

# Run the main function
main
