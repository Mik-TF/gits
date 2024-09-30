#!/bin/bash

# ANSI color codes
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to perform git pull operations
pull() {
    git checkout development && git stash && git fetch && git pull && git status
}

# Function to perform git push operations
push() {
    git add .
    echo "Enter commit message:"
    read commit_message
    git commit -m "$commit_message"
    git push
}

# Function to install the script
install() {
    echo -e "${YELLOW}Installing GitS...${NC}"
    if sudo -v; then
        sudo cp "$0" /usr/local/bin/gits
        sudo chown root:root /usr/local/bin/gits
        sudo chmod 755 /usr/local/bin/gits

        echo -e "${GREEN}GitS has been installed successfully.${NC}"
        echo -e "You can now use ${YELLOW}gits${NC} command from anywhere."
        echo -e "Use ${BLUE}gits help${NC} to see the commands."
    else
        echo -e "${RED}Error: Failed to obtain sudo privileges. Installation aborted.${NC}"
        exit 1
    fi
}

# Function to uninstall the script
uninstall() {
    echo -e "${YELLOW}Uninstalling GitS...${NC}"
    if sudo -v; then
        sudo rm -f /usr/local/bin/gits

        echo -e "${GREEN}GitS has been uninstalled successfully.${NC}"
    else
        echo -e "${RED}Error: Failed to obtain sudo privileges. Uninstallation aborted.${NC}"
        exit 1
    fi
}

# Function to display help information
help() {
    echo -e "${BLUE}GitS - Git Speed${NC}"
    echo -e "${YELLOW}Description:${NC} GitS is a tool for quickly combining git commands to speed up your workflow."
    echo -e "${YELLOW}Usage:${NC} gits <command>"
    echo
    echo -e "${GREEN}Available commands:${NC}"
    echo -e "  ${YELLOW}pull${NC}      Quickly update your local repository"
    echo -e "             ${BLUE}Actions:${NC} checkout development, stash changes, fetch, pull, show status"
    echo -e "             ${BLUE}Example:${NC} gits pull"
    echo
    echo -e "  ${YELLOW}push${NC}      Rapidly stage, commit, and push changes"
    echo -e "             ${BLUE}Actions:${NC} add all changes, prompt for commit message, commit, push"
    echo -e "             ${BLUE}Example:${NC} gits push"
    echo
    echo -e "  ${YELLOW}install${NC}   Install GitS to /usr/local/bin (requires sudo)"
    echo -e "             ${BLUE}Example:${NC} gits install"
    echo
    echo -e "  ${YELLOW}uninstall${NC} Remove GitS from /usr/local/bin (requires sudo)"
    echo -e "             ${BLUE}Example:${NC} gits uninstall"
    echo
    echo -e "  ${YELLOW}help${NC}      Display this help message"
    echo -e "             ${BLUE}Example:${NC} gits help"
    echo
    echo -e "${GREEN}Examples:${NC}"
    echo -e "  ${BLUE}Pull changes:${NC}"
    echo -e "    gits pull"
    echo
    echo -e "  ${BLUE}Push changes:${NC}"
    echo -e "    gits push"
    echo -e "    ${YELLOW}Enter commit message:${NC} Update README.md"
    echo
    echo -e "${YELLOW}Note:${NC} Ensure you're in your git repository directory when running git-related commands."
}

# Main execution logic
main() {
    # Check if an argument is provided
    if [ $# -eq 0 ]; then
        help
        exit 1
    fi

    # Execute the appropriate function based on the argument
    case "$1" in
        pull)
            pull
            ;;
        push)
            push
            ;;
        install)
            install
            ;;
        uninstall)
            uninstall
            ;;
        help)
            help
            ;;
        *)
            echo -e "${YELLOW}Unknown command:${NC} $1"
            echo "Run 'gits help' for usage information."
            exit 1
            ;;
    esac
}

# Run the main function
main "$@"