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
sudo apt install -y software-properties-common build-essential autoconf pkg-config make gcc g++ screen nano wget curl ntp fail2ban nginx

sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo add-apt-repository -y ppa:longsleep/golang-backports

sudo apt update
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

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | echo -e "pool\n" | sudo bash
source ~/.bashrc
sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install v8.1.4
nvm use v8.1.4
npm update -g

npm install -g ember-cli@2.9.1
npm install -g bower
npm install
bower install
chmod +x build.sh
./build.sh
cd ../
sudo cp misc/nginx-default.conf /etc/nginx/sites-available/default
systemctl enable nginx.service && systemctl stop nginx.service && systemctl start nginx.service
#screen -S pool ./build/bin/ethash-mining-pool config_api.json

echo "Installation completed!"

exit 0
