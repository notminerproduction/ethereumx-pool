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
sudo apt install -y software-properties-common build-essential autoconf pkg-config make gcc g++ screen nano wget curl ntp fail2ban nginx unrar unzip

sudo add-apt-repository -y ppa:chris-lea/redis-server
#sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo add-apt-repository -y ppa:longsleep/golang-backports

sudo apt update
sudo apt autoremove -y
sudo apt install -y redis-server golang-go
#libdb4.8-dev libdb4.8++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev 
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl enable ntp
sudo systemctl start ntp

#wget https://github.com/Ethereum-x/Ethereum-x-go/releases/download/etx-v1.4/getx-v1.4-linux-amd64.tar.gz
tar -xf getx-v1.4-linux-amd64.tar.gz
rm get*.gz

git config --global http.https://gopkg.in.followRedirects true
git clone -b V2.0_Eth https://github.com/techievee/ethash-mining-pool.git
mv ethash-mining-pool/ ethereumx-pool/
cd ethereumx-pool
rm *.json
mv ~/ethereumx-pool/config_api.json ~/ethereumx-pool/ethereumx-pool/
git clone https://github.com/notminerproduction/statistics_api.git
sudo chown $USER:$GROUP ~/ethereumx-pool/*
sudo chown $USER:$GROUP ~/ethereumx-pool/.
rm -rf www/
mv statistics_api/ www/
rm www/config/environment*
mv ~/ethereumx-pool/environment.js ~/ethereumx-pool/ethereumx-pool/www/config/
sudo mv ~/ethereumx-pool/default /etc/nginx/sites-available/
#mv ~/ethereumx-pool/getx ../
touch ~/pwd
\cp -rf ~/ethereumx-pool/ethereumx-pool/* ~/ethereumx-pool
cd ~/ethereumx-pool
rm -rf ethereumx-pool/
rm ~/ethereumx-pool/payouts/unlocker.go
mv ~/ethereumx-pool/unlocker.go ~/ethereumx-pool/payouts
make

#sudo rm -rf ~/.nvm
#sudo rm -rf ~/.npm

cd www/
#sudo rm package.json
#mv ~/ethereumx-pool/package.json ~/ethereumx-pool/www

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc
#sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install v4.5
nvm use v4.5
npm install

./node_modules/.bin/bower install
#unrar x ~/ethereumx-pool/intl-format-cache.rar ~/ethereumx-pool/www/node_modules/intl-format-cache/ -Y
#rm ~/ethereumx-pool/intl-format-cache.rar
chmod +x build.sh
#./build.sh
#cd ~/ethereumx-pool
sudo systemctl enable nginx.service && sudo systemctl stop nginx.service && sudo systemctl start nginx.service
#screen -S pool ./build/bin/ethash-mining-pool config_api.json

echo "Installation completed!"

exit 0
