Thanks to [Tania Rascia](https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/) for the inspiration.

Here's the complete script: [script.sh](script.sh)

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
- ScreenFlow: Edit screencasts.
- TimeMachineEditor: Allows to edit Time Machine frequency
- VirtualBox
- Zoom
- Cacher: Store code snippets

```bash
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
  screenflow \  
  cacher
```

### Alfred

I recommend to change sync folder to your Drive/Dropbox folder so you don't lose changes.

### PhpStorm
My Storm Settings: https://github.com/igmoweb/storm-settings (Private, sorry)
I use [Dark Purple](https://plugins.jetbrains.com/plugin/12100-dark-purple-theme) theme with a few customizations.

### Time Machine Editor

I set a backup every day but do not back it up from 20:00 to 8:00

### Bear backups

I don't use the paid version of Bear so I create a cronjob to back it up every day at 11 am and place a copy inside Drive folder:

First, create the script to create a backup:

```bash
cat <<EOT > ~bin/bear-backup
#!/usr/bin/env bash

rm -rf ~/Drive/Bear/db-backup
cp -r ~/Library/Group\ Containers/9K33E3U3T4.net.shinyfrog.bear/Application\ Data ~/Drive/Bear/db-backup
EOT
sudo chmod 755 ~/bin/bear-backup
```

Add the script to your crontab by running `crontab -e` and then insert this line:

`0 11 * * * ~/bin/bear-backup`

Save and you should be done.

### Other Apps
These apps must be installed manually. Either they are paid apps or they are not mirrored in Homebrew.

- magnet: A window resizer. [https://apps.apple.com/es/app/magnet/id441258766?mt=12](https://apps.apple.com/es/app/magnet/id441258766?mt=12)
- caffeine: Keep your mac awake, even if you are not using it. [http://lightheadsw.com/caffeine/](http://lightheadsw.com/caffeine/)
- hub: A GitHub helper in the command line. Install instructions: [https://github.com/github/hub](https://github.com/github/hub)
- Skitch: Easy screenshots [https://apps.apple.com/es/app/skitch/id425955336?mt=12](https://apps.apple.com/es/app/skitch/id425955336?mt=12)
- Karabiner: Map your keyboard. [https://karabiner-elements.pqrs.org/](https://karabiner-elements.pqrs.org/)
- SSH Proxy: [https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12](https://apps.apple.com/us/app/ssh-proxy/id597790822?mt=12)
- Bear: Take notes [https://apps.apple.com/us/app/bear-beautiful-writing-app/id1091189122](https://apps.apple.com/us/app/bear-beautiful-writing-app/id1091189122)
- Vagrant: [https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

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
I often use a `ignacio.php` for tweaks in WordPress installs that I don't need to see in production. `.idea` is a folder that PhpStorm generates.
```
.idea
ignacio.php
```

## PHP and Composer install

I normally work inside a Virtual Machine but I also have PHP installed locally so I can execute things with composer:

Change the 7.2 if needed:
```bash
curl -s http://php-osx.liip.ch/install.sh | bash -s 7.2
export PATH=/usr/local/php5/bin:$PATH  
php -v 
```

Install Composer:
```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/
sudo chmod 755 /usr/local/bin/composer.phar
```

````bash
cat <<EOT >> ~/.zshrc
alias composer="php /usr/local/bin/composer.phar"
EOT
````

You also may want to use `phpcs` to do some code reviews. I use it especially for security reviews. It's an automated way to spot security issues quickly:

First, make `phpcs` available globally from your user `bin` folder. If the folder does not exist, you need to create it.

```bash
touch ~/bin/phpcs
```

Now create a binary to make the `phpcs` command available globally

```bash
cat <<EOT >> ~/bin/phpcs
if (is_file(__DIR__.'/../autoload.php') === true) {
    include_once __DIR__.'/../autoload.php';
} else {
    include_once 'PHP/CodeSniffer/autoload.php';
}

$runner   = new PHP_CodeSniffer\Runner();
$exitCode = $runner->runPHPCS();
exit($exitCode);
EOT
sudo chmod 755 ~/bin/phpcs 
```

Make sure that everything is fine `phpcs --help`

In order to make my security code reviews, I create a set of rules in my home dir:

```bash
touch ~/phpcs-security.xml
cat <<EOT >> ~/phpcs-security.xml
<?xml version="1.0"?>
<ruleset name="Security">
    <description>Security reviews with PHPCS.</description>

    <file>.</file>

    <!-- Exclude the Composer Vendor directory. -->
    <exclude-pattern>/vendor/*</exclude-pattern>

    <!-- Exclude the Node Modules directory. -->
    <exclude-pattern>/node_modules/*</exclude-pattern>

    <!-- wpcs installed path -->
    <config name="installed_paths" value="/Users/ignacio/.composer/vendor/wp-coding-standards/wpcs" />

    <!-- PHPCS WP Aliases. Needed to execute WP Rules -->
    <autoload>/Users/ignacio/.composer/vendor/wp-coding-standards/wpcs/WordPress/PHPCSAliases.php</autoload>

    <!-- Just check php files -->
    <arg name="extensions" value="php"/>

    <!-- Colors! Nice! -->
    <arg name="colors"/>
    <arg value="s"/>

    <!-- Set of rules we're going to use -->
    <rule ref="WordPress.Security"/>
    <rule ref="WordPress.DB.PreparedSQL"/>
    <rule ref="WordPress.WP.GlobalVariablesOverride"/>
    <rule ref="Squiz.PHP.Eval"/>
    <rule ref="Squiz.PHP.Eval.Discouraged" />
</ruleset>
EOT
```

So now you can run `phpcs --standard=~/phpcs-security.xml .`



