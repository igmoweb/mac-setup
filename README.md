Thanks to [Tania Rascia](https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/) for the inspiration.
Here's the script: [./script.sh](.script.sh)

## Homebrew

Homebrew allows you to install apps from the command line.

### Install
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

### And update
`brew update`

## Git

```shell script
brew install git
```

## Apps

- PhpStorm
- Sublime Text
- Atom
- Chrome
- Firefox
- iTerm2
- Docker
- VLC Media Player
- 1Password
- Alfred: Manage workflows and automation
- Anki: Learn by repetition
- Insomnia: Play with REST APIs
- Bear: Take notes
- Spotify
- Google Backup and Sync: To sync files with Drive
- Feedly: Read feeds
- Filezilla: Sometimes I need FTP
- Oversight: Warns you when something is about to use the microphone or camera.
- Kap: Record your screen and export to GIFs
- Local by Flywheel: An extra dev environment
- MAMP: An extra dev environment
- OmniDiskSweeper: Free your HD space
- Pocket: Save stuff to read later but actually never read it
- RAR: Sometimes you find RARs
- Skype
- TimeMachineEditor: Allows to edit Time Machine frequency
- VirtualBox
- Zoom
- Cacher: Store code snippets

```shell script
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
```

### Alfred

I recommend to change sync folder to your Drive/Dropbox folder so you don't lose changes.

### PhpStorm
My Storm Settings: https://github.com/igmoweb/storm-settings (Private, sorry)
I use [Dark Purple](https://plugins.jetbrains.com/plugin/12100-dark-purple-theme) theme with a few customizations.

### Time Machine Editor

I set a backup every day but do not back it up from 20:00 to 8:00

### Other Apps
These apps must be installed manually. Either they are paid apps or they are not mirrored in Homebrew.

- magnet: A window resizer. [https://apps.apple.com/es/app/magnet/id441258766?mt=12](https://apps.apple.com/es/app/magnet/id441258766?mt=12)
- caffeine: Keep your mac awake, even if you are not using it. [http://lightheadsw.com/caffeine/](http://lightheadsw.com/caffeine/)
- hub: A GitHub helper in the command line. Install instructions: [https://github.com/github/hub](https://github.com/github/hub)
- Skitch: Easy screenshots [https://apps.apple.com/es/app/skitch/id425955336?mt=12](https://apps.apple.com/es/app/skitch/id425955336?mt=12)
- Karabiner: Map your keyboard. [https://karabiner-elements.pqrs.org/](https://karabiner-elements.pqrs.org/)
- SSH Proxy: [https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12](https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12)

### Chrome extensions

- Cacher: Allows to copy snippets from any site and save them into Cacher.
- 1Password
- Form Save and Restore: saves form data and then restores it when you want it. (For testing).
- Grammarly for Chrome.
- Guarda la imagen como quieras: Store images in any format.
- JSON viewer: JSON/JSONP highlighter.
- Keepa: Amazon price tracker.
- React and Redux developer tools.
- React Performance dev tool.
- Save to Pocket: Bookmarks a site in Pocket.
- Send to Kindle for Google Chrome.
- Web Developer: I don't use it often but it has some features that I use from time to time.
- ZenHub for GitHub: To  manage projects inside GitHub.

## Shell

[Oh My Zsh](https://ohmyz.sh/) to improve your terminal.
`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

I use [powerlevel10k Theme](https://github.com/romkatv/powerlevel10k)

`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

I have a few customizations in my .zshrc file:

### Shell aliases

Edit your `.zshrc` and add the following line:
```bash
alias laxo='ls -laxo'
```

### GitHub aliases (If hub has been previously installed)

Edit your `.zshrc` and add the following lines:
```bash
alias pulls='git browse -- pulls' # Opens the current repo PRs list URL.
alias repo='git browse' # Opens the current repo URL.
alias mypulls='git browse -- pulls/igmoweb' # Opens the current repo PRs list URL authored by me.
alias wiki='git browse -- wiki' # Opens the current repo Wiki URL.
alias gprl='git pr list --format="%sC%>(8)%i%Creset %U %n         %t%  l%n%n"' # Display a list of the current opened PRs with colors.
alias gnpr='git pull-request' # Create a new PR from the current branch to the default branch.

# Navigates to a given issue ID. Run issue ID in your terminal.
function issue() {
	git browse -- issues/$1
}
```

### Preventing rm doom

In order to prevent something like `rm -rf` by mistake, I use a function that overrides it. Edit your .zshrc and add the following lines:

```bash
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
```

Reopen your terminal and whenever you try to run `rm -rf`, the deleted content will be sent to trash instead of to the forgotten realm.

## nvm, node and yarn

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
brew install yarn
```

## Cacher and Alfred integration
`npm install --g alfred-cacher`

## Git config

### Global Git config:
`touch ~/.gitconfig`

### Global .gitignore
I use often a `ignacio.php` for tweaks in WordPress installs that I don't need to see in production. `.idea` is a folder that PhpStorm generates.
```
.idea
ignacio.php
```



