# ethereumx-pool
sudo su
useradd -m -s /bin/bash pool
usermod -aG sudo pool
echo "pool:pool" | sudo chpasswd
su - pool
git clone https://github.com/notminerproduction/ethereumx-pool.git
cd ~/ethereumx-pool
./install.sh

su - pool
cd ~/ethereumx-pool

./getx --account new

#set password from wallet
nano /home/pool/pwd

screen -S getx ./getx --rpc --maxpeers 75 --syncmode "fast" --rpcapi "net,web3,personal" --etherbase "$WALLET" --cache=12288 --mine --unlock "$WALLET" --allow-insecure-unlock --password ~/pwd &

su - pool
cd ~/ethereumx-pool
screen -S pool ./build/bin/ethash-mining-pool config_api.json &

DONT FORGET CHANGE PASSWORD FOR USER pool!
