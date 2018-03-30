#!/bin/bash
# install
clear
echo "*********** Welcome to the CitrusCash (CITR) Masternode Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 16.04 !'
echo '****************************************************************************'
sleep 3
echo '*** Step 1/3 ***'
echo '*** Installing packages & copying Force wallet ***'
sleep 2
sudo add-apt-repository ppa:bitcoin/bitcoin -y
apt-get install \
  build-essential libtool \
  autotools-dev automake \
  pkg-config libssl-dev \
  libevent-dev bsdmainutils \
  libboost-all-dev libminiupnpc-dev \
  libzmq3-dev libqrencode-dev \
  libdb4.8-dev libdb4.8++-dev \
  libzmq3-dev \
  git python-virtualenv -y

# install Citrus core
wget https://github.com/wantdev/WantCore/releases/download/v1.1.1/Ubuntu.16.04.tar.gz
tar xvzf Ubuntu.16.04.tar.gz
mv -R want* /sur/local/bin/
rm -R Ubuntu.16.04.tar.gz
sleep 3
echo '*** Step 2/3 ***'
echo '*** Coinfig daemon ***'
sleep 2
echo -n "RPC User:"
read user
echo -n "RPC Password:"
read password
echo -n "Masternode genkey: "
read mngenkey
echo -n "VPS IP (only x.x.x.x no port): "
read ipaddress
mkdir -p ~/.wantcore/
echo -e "rpcuser=$user" >> ~/.wantcore/want.conf
echo -e "rpcpassword=$password" >> ~/.wantcore/want.conf
echo -e "rpcport=11225" >> ~/.wantcore/want.conf
echo -e "rpcallowip=127.0.0.1" >> ~/.wantcore/want.conf
echo -e "server=1" >> ~/.wantcore/want.conf
echo -e "daemon=1" >> ~/.wantcore/want.conf
echo -e "staking=0" >> ~/.wantcore/want.conf
echo -e "masternode=1" >> ~/.wantcore/want.conf
echo -e "masternodeprivkey=$mngenkey" >> ~/.wantcore/want.conf
echo -e "externalip=$ipaddress:7676" >> ~/.wantcore/want.conf
echo -e "addnode=104.237.137.31:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=146.120.209.53:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=178.62.194.181:40734 " >> ~/.wantcore/want.conf
echo -e "addnode=18.218.56.89:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=185.185.70.109:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=195.177.209.15:49680 " >> ~/.wantcore/want.conf
echo -e "addnode=195.201.20.101:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=207.148.76.112:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=46.105.55.113:7676 " >> ~/.wantcore/want.conf
echo -e "addnode=77.247.23.115:51910" >> ~/.wantcore/want.conf

sleep 3
echo '*** Step 3/4 ***'
echo '*** Start daemon ***'
sleep 2
wantd -reindex=1
sleep 3
echo '*** Step 4/4 ***'
echo '*** Setings Sentinel ***'
sleep 2
cd ~ && git clone https://github.com/wantdev/Sentinel.git
cd ~ && cd Sentinel  && export LC_ALL=C && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt
sleep 2
echo "** sync **"
echo '****************************************************************************'
sleep 60
echo "** add crontab **"
echo '****************************************************************************'
echo -e "* * * * * cd /root/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> /var/spool/cron/crontabs
sleep 2
echo 'done'
