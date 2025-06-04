# Load configs
source $HOME/dotfiles/zsh/path.zsh
source $HOME/dotfiles/zsh/env.zsh
source $HOME/dotfiles/zsh/options.zsh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/completion.zsh
source $HOME/dotfiles/zsh/key-bindings.zsh

# Load plugins
source $HOME/dotfiles/zsh/plugins/zsh-shift-select.plugin.zsh

# Set the window title nicely no matter where you are
DISABLE_AUTO_TITLE="true"
_set_terminal_title() {
  local title="$(basename "$PWD")"
  if [[ -n $SSH_CONNECTION ]]; then
    title="$title \xE2\x80\x94 $HOSTNAME"
  fi
  print -Pn "\e]2;$title\a"
}
# Call the function before displaying the prompt
precmd_functions+=(_set_terminal_title)

# Activate Fish-like autosuggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#homebrew
[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable Fish-like syntax highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable fzf: https://github.com/junegunn/fzf
if [ $(command -v "fzf") ]; then
  source $HOME/dotfiles/zsh/fzf.zsh
fi

# Setup zoxide: https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
export _ZO_DATA_DIR=$HOME
eval "$(zoxide init --cmd cd zsh)"

# Allow local (private) customizations (not checked in to version control)
[ -f ~/.zsh.local ] && source ~/.zsh.local

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Add GPG key
export GPG_TTY=$(tty)

# Welcome!
# fastfetch


export PATH="/opt/homebrew/bin:$PATH"

export AWS_VAULT_KEYCHAIN_NAME="login"

export AWS_SESSION_TTL="12h"

export GRADLE_USER_HOME="$HOME/.gradle"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# . ~/.asdf/plugins/java/set-java-home.zsh

# . ~/.asdf/plugins/golang/set-env.zsh

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias pc=$(which perctl)

export GOPRIVATE=gitlab.personio-internal.de

alias mc=~/dev/personio/monolith-cli

# Configure Colima as Docker Host for applications which don't respect Docker Contexts
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock

# Testcontainers should use the default Docker Socket
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

# Testcontainers should use the Colima VM instance local address as host
export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address // ""')

# Set AWS_DEFAULT_PROFILE to dev by default
export AWS_DEFAULT_PROFILE=dev
export AWS_ECR_IGNORE_CREDS_STORAGE=true

alias kubectx="kubectl-ctx"

alias kubens="kubectl-ns"

eval "$(starship init zsh)"

