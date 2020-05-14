# ethereumx-pool
    sudo su
    useradd -m -s /bin/bash pool
    usermod -aG sudo pool
    echo "pool:pool" | sudo chpasswd
    su - pool
    git clone https://github.com/notminerproduction/ethereumx-pool.git
    cd ~/ethereumx-pool
    ./install.sh

# create wallet
    su - pool
    cd ~/ethereumx-pool
    ./getx --account new

# set password for wallet
    nano /home/pool/pwd

# run blockchain sync
    #!/bin/bash
    WALLET="HERE_WALLET_ADDRESS"
    screen -S getx ./getx --rpc --maxpeers 75 --syncmode "fast" --rpcapi "net,web3,personal" --etherbase "$WALLET" --cache=12288 --mine --unlock "$WALLET" --allow-insecure-unlock --password ~/pwd &

# run pool
    su - pool
    cd ~/ethereumx-pool
    screen -S pool ./build/bin/ethash-mining-pool config_api.json &

# DONT FORGET CHANGE PASSWORD FOR USER pool!
    sudo passwd pool
