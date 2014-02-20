#!/bin/bash

set -e

echo "Updates packages. Asks for your password."
sudo apt-get update -y

echo "Installs packages. Give your password when asked."
sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev nodejs -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
source ~/.bashrc
source ~/.bash_profile

echo "Installs Ruby"
rvm install ruby-2.1.0
rvm use ruby-2.1.0 --default

gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri

echo -e "\n- - - - - -\n"
echo -e "Now we are going to print some information to check that everything is done:\n"

echo -n "Should be sqlite 3.7.3 or higher: sqlite "
sqlite3 --version
echo -n "Should be rvm 1.6.32 or higher:          "
rvm --version | sed '/^.*$/N;s/\n//g' | cut -c 1-10
echo -n "Should be ruby ruby-2.1.0p0:             "
ruby -v | cut -d " " -f 2
echo -n "Should be Rails 4.0.0 or higher:         "
rails -v
echo -e "\n- - - - - -\n"

echo "If the versions match, everything is installed correctly. If the versions
don't match or errors are shown, something went wrong with the automated process
and we will help you do the installation the manual way at the event.

If you encounter the message:
    The program 'rails' is currently not installed.

It is just a hiccup with the shell, solutions:
    $ source ~/.rvm/scripts/rvm
    Allow login shell, example http://rvm.io/integration/gnome-terminal/"
