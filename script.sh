#!/usr/bin/env bash

# ========== Homebrew ==========
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# ========== Git ==========
brew install git

# ========== Apps ==========
brew cask install \
  phpstorm \
  sublime-text \
  atom \
  google-chrome \
  firefox \
  iterm2 \
  docker \
  vlc \
  1password \
  lastpass \
  alfred \
  anki \
  insomnia \
  spotify \
  google-backup-and-sync \
  feedly \
  oversight \
  filezilla \
  kap \
  local \
  mamp \
  omnidisksweeper \
  pocket \
  rar \
  skype \
  timemachineeditor \
  zoomus \
  cacher

# Action needed: change Alfred sync folder to Drive
# Action needed: phpStorm settings: https://github.com/igmoweb/storm-settings and theme https://plugins.jetbrains.com/plugin/12100-dark-purple-theme
# Action needed: Time Machine Editor: set a backup every day but do not back it up from 20:00 to 8:00
# Actions needed: Install these apps manually:
# - magnet: A window resizer. [https://apps.apple.com/es/app/magnet/id441258766?mt=12](https://apps.apple.com/es/app/magnet/id441258766?mt=12)
# - caffeine: Keep your mac awake, even if you are not using it. [http://lightheadsw.com/caffeine/](http://lightheadsw.com/caffeine/)
# - hub: A GitHub helper in the command line. Install instructions: [https://github.com/github/hub](https://github.com/github/hub)
# - Skitch: Easy screenshots [https://apps.apple.com/es/app/skitch/id425955336?mt=12](https://apps.apple.com/es/app/skitch/id425955336?mt=12)
# - Karabiner: Map your keyboard. [https://karabiner-elements.pqrs.org/](https://karabiner-elements.pqrs.org/)
# - SSH Proxy: [https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12](https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12)

# ========== Oh My Zsh ==========
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Reload .zshrc without closing the terminal.
. ~/.zshrc

# Oh My Zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# Action needed: Open your ~/.zshrc and change the theme to powerlevel10k/powerlevel10k
# Action needed: Close and open your terminal to see the new theme

# aliases and functions
cat <<EOT >> ~/.zshrc
alias pulls='git browse -- pulls'
alias repo='git browse'
alias mypulls='git browse -- pulls/igmoweb'
alias wiki='git browse -- wiki'
alias gprl='git pr list --format="%sC%>(8)%i%Creset %U %n         %t%  l%n%n"'
alias gnpr='git pull-request'
function issue() {
	git browse -- issues/$1
}

function rm() {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      /bin/mv "$path" ~/.Trash/"$dst"
    fi
  done
}
EOT

# Reload .zshrc without closing the terminal.
. ~/.zshrc

# ========== nvm, node and yarn ==========
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
brew install yarn

# ========== Cacher and Alfred integration ==========
npm install --g alfred-cacher

# ========== Git config ==========
touch ~/.gitconfig
cat <<EOT >> ~/.gitignore-global
.idea
ignacio.php
EOT
