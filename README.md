# ethereumx-pool
    sudo su
    useradd -m -s /bin/bash pool
    usermod -aG sudo pool
    echo "pool:pool" | sudo chpasswd
    su - pool
    git clone https://github.com/notminerproduction/ethereumx-pool.git
    cd ~/ethereumx-pool
    chmod +x ./install.sh
    ./install.sh

# create wallet
    su - pool
    cd ~/ethereumx-pool
    ./getx --account new

# put wallet password
    su - pool
    nano ~/pwd

# run blockchain sync
    nano ./start_getx.sh #set wallet address
    #!/bin/bash
    WALLET="HERE_WALLET_ADDRESS"
    screen -S getx ./getx --rpc --maxpeers 75 --syncmode "fast" --rpcapi "net,web3,personal" --etherbase "$WALLET" --cache=12288 --mine --unlock "$WALLET" --allow-insecure-unlock --password ~/pwd
    
    chmod +x ./start_getx.sh
    ./start_getx.sh

# must be changed
    nano ~/ethereumx-pool/config_api.json #wallet address
    nano ~/ethereumx-pool/www/config/environment.js #192.168.0.200 of your IP or DNS

# run pool
    su - pool
    cd ~/ethereumx-pool
    screen -S pool ./build/bin/ethash-mining-pool config_api.json

# DONT FORGET CHANGE PASSWORD FOR USER pool!
    sudo passwd pool
