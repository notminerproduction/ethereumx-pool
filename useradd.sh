#!/bin/bash
useradd -m -s /bin/bash pool
usermod -aG sudo pool
echo "pool:pool" | sudo chpasswd
echo "Password of user pool is pool after full installation you must change this password!"
su - pool
exit 0
