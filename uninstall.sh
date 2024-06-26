#!/bin/bash

# Main function
main() {
  # Repository URL
  local repo_dir="${HOME}/repositories/git/linux-aliases"

  # Delete the repository if it exists
  if [ -d "${repo_dir}" ]; then
    rm -rf "${repo_dir}"
  fi

  # Exit if no .bashrc file is found
  if [ ! -f "${HOME}/.bashrc" ]; then
    echo "No .bashrc file found. Exiting..."
    return
  fi

  # Remove run.sh script from the cloned repository inside ~/.bashrc, but only if it is in .bashrc
  if grep -q "source ${repo_dir}/run.sh" "${HOME}/.bashrc"; then
    sed -i "/source ${repo_dir}\/run.sh/d" "${HOME}/.bashrc"
  fi
}

# Run the main function
main
