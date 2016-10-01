#!/bin/sh

exit 0

sudo apt -y install software-properties-common ppa-purge
sudo add-apt-repository -y ppa:elementary-os/stable
sudo ppa-purge -y ppa:elementary-os/daily

echo "do upgrade"

    # receive keys
    figlet "upkeys"     && sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com `sudo aptitude update 2>&1 | grep -o '[0-9A-Z]\{16\}$' | xargs`

    # force update
    figlet "update"     && sudo apt-get -y update
    figlet "dist-up"    && sudo apt-get -y dist-upgrade
    figlet "force deps" && sudo apt-get -y -f install
    figlet "remove"     && sudo apt-get -y autoremove
    figlet "autoclean"
    sudo apt-get -y autoclean
    sudo apt-get -y clean
    sudo dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge
    sudo updatedb
    figlet "done"
