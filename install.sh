#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "${1}" >/dev/null 2>&1
}

# Function to install the required packages
install_packages() {
  local packages=("$@")
  if command_exists apt-get; then
    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"
  elif command_exists dnf; then
    sudo dnf install -y "${packages[@]}"
  elif command_exists yum; then
    sudo yum install -y "${packages[@]}"
  elif command_exists zypper; then
    sudo zypper install -y "${packages[@]}"
  else
    echo "No package manager found. Please install the required packages manually."
  fi
}

# Main function
main() {
  # Repository URL
  local repo_url="https://github.com/Panzer1119/linux-aliases.git"
  local repo_dir="${HOME}/repositories/git/linux-aliases"
  local packages=("git" "eza")

  # Check if running as root
  if [ "$(id -u)" -eq 0 ]; then
    echo "Running as root. Installing required packages..."

    # Install packages
    install_packages "${packages[@]}"
  else
    echo "Not running as root. Skipping package installation..."
  fi

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

  # Check if the packages are installed
  local package
  for package in "${packages[@]}"; do
    if ! command_exists "${package}"; then
      echo "The '${package}' package is not installed. Please install it manually if you want to use all aliases."
    fi
  done

  # Execute run.sh script from the cloned repository inside ~/.bashrc, but only if not already in .bashrc
  if ! grep -q "source ${repo_dir}/run.sh" "${HOME}/.bashrc"; then
    echo "source ${repo_dir}/run.sh" >>"${HOME}/.bashrc"
  fi

  # Source all alias files in the repository, so the aliases are still usable after this install script exits
  local file
  for file in "${repo_dir}/aliases"/*; do
    [ -f "${file}" ] && source "${file}"
  done
}

# Run the main function
main
