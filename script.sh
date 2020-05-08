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
source ~/.zshrc

# Oh My Zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# Action needed: Open your ~/.zshrc and change the theme to powerlevel10k/powerlevel10k
# Action needed: Close and open your terminal to see the new theme

# aliases and functions
cat <<EOT >> ~/.zshrc
alias laxo='ls -laxo'
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
source ~/.zshrc

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

# ========== PHP config ==========
curl -s http://php-osx.liip.ch/install.sh | bash -s 7.2
export PATH=/usr/local/php5/bin:$PATH
php -v

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/
sudo chmod 755 /usr/local/bin/composer.phar

cat <<EOT >> ~/.zshrc
alias composer="php /usr/local/bin/composer.phar"
EOT

source ~/.zshrc
composer -v

# And composer dependencies
composer global require phpunit/phpunit squizlabs/php_codesniffer humanmade/coding-standards

# Create a security coding standards config file
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

# Create a binary to run phpcs globally
touch ~/bin/phpcs
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

# Create a script to backup Bear database
cat <<EOT > ~bin/bear-backup
#!/usr/bin/env bash

rm -rf ~/Drive/Bear/db-backup
cp -r ~/Library/Group\ Containers/9K33E3U3T4.net.shinyfrog.bear/Application\ Data ~/Drive/Bear/db-backup
EOT
sudo chmod 755 ~/bin/bear-backup

# And add it to a cron job
crontab -e

# Add this line to your cron jobs list:
0 11 * * * ~/bin/bear-backup
