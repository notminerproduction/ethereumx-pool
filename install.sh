#!/bin/bash
echo "Pool install script."
echo "Installing... Please wait!"

sleep 3

echo "Password of new user pool is pool, please change after full installations!"

sleep 3

echo -e "pool\n" | sudo -S rm -rf /usr/lib/node_modules
sudo apt remove --purge -y nodejs node
sudo rm /etc/apt/sources.list.d/nodesource.list*
sudo apt update
sudo apt upgrade -y
sudo apt install -y software-properties-common build-essential autoconf pkg-config make gcc g++ screen nano wget curl ntp fail2ban nginx unrar

sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo add-apt-repository -y ppa:longsleep/golang-backports

sudo apt update
sudo apt autoremove -y
sudo apt install -y libdb4.8-dev libdb4.8++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev redis-server golang-go

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl enable ntp
sudo systemctl start ntp

wget https://github.com/Ethereum-x/Ethereum-x-go/releases/download/etx-v1.4/getx-v1.4-linux-amd64.tar.gz
tar -xf getx-v1.4-linux-amd64.tar.gz
rm get*.gz

git config --global http.https://gopkg.in.followRedirects true
git clone -b V2.0_Eth https://github.com/techievee/ethash-mining-pool.git
mv ethash-mining-pool/ ethereumx-pool/
cd ~/ethereumx-pool
make
rm config_payout.json
rm config_proxy.json
rm config_unlocker.json
sudo rm -rf ~/.nvm
sudo rm -rf ~/.npm

git clone -b v1.0_Eth https://github.com/techievee/statistics_api.git

rm -rf www/
mv statistics_api/ www/
cd www

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sudo bash
source ~/.bashrc
sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install v8.1.4
nvm use v8.1.4
#npm update -g

#npm install -g webpack@4.29.3 pm2@4.2.1
#npm install -g npm@latest

#npm install ember-cli@2.9.1
#npm install bower
#npm install fsevents@latest -f --save-optional
#npm install cldr-core@34.0.0
#npm install intl-format-cache@4.2.22
#npm install format-number
#npm install ember-cli-accounting
#npm install core-js@3.6.4
#npm install jquery@3.4.0
#npm install @babel/core@^7.0.0-beta.42
#npm install babel-plugin-debug-macros@0.2.0
#npm install ember-intl@4.3.0
#npm install minimatch@3.0.2
#npm install ember-cli-babel@7.18.0
#npm install ember-resolver@7.0.0
npm install

npm audit fix
#npm audit fix --force
#~/.nvm/versions/node/v13.14.0/bin/bower install
./node_modules/.bin/bower install
wget https://files.gitter.im/sammy007/open-ethereum-pool/IBJl/intl-format-cache.rar
unrar x intl-format-cache.rar node_modules/intl-format-cache/ -Y
chmod +x build.sh

rm ~/ethereumx-pool/*.json
rm ~/ethereumx-pool/www/config/environment_in.js
cp ~/config_api.json ~/ethereumx-pool/
cp ~/environment.js ~/ethereumx-pool/www/config/
sudo cp ~/default /etc/nginx/sites-available/default

cd ~/ethereumx-pool/www
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
./build.sh
cd ~
sudo systemctl enable nginx.service && sudo systemctl stop nginx.service && sudo systemctl start nginx.service
#screen -S pool ./build/bin/ethash-mining-pool config_api.json

echo "Installation completed!"

exit 0
