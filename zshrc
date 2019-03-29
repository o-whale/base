#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Bluewhale <blue@owhale.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# start ssh agent once login & kill ssh agent once exit
eval "$(ssh-agent -s)"
TRAPEXIT() {
  ssh-agent -k
}
