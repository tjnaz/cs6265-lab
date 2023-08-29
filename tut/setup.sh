#!/bin/bash

apt-get -y update

apt-get -y install gdb emacs vim git zsh gdb-multiarch python2.7 python-pip \
        python-dev libssl-dev libffi-dev build-essential execstack \
        rdiff-backup python3-pip gdbserver libelf-dev \
        linux-headers-$(uname -r)

# Install 32 bit libs
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get -y install libc6-dev-i386

# Enable ptrace
echo "kernel.yama.ptrace_scope=0" | sudo tee -a /etc/sysctl.conf
# reload sysctl
sysctl --system

# Installing tools
pip install -U setuptools
pip install pwntools
pip uninstall -y pyelftools
pip install pyelftools==0.24
pip install ROPGadget
pip install ropper
pip3 install pycrypto

timedatectl set-timezone 'EST'

sudo apt-get install sshpass
# sudo mv /home/vagrant/seclab /bin/seclab
# sudo chmod +x /bin/seclab

# pwndbg
cd /home/vagrant
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
rm requirements.txt
echo "attrs==21.4.0
capstone==4.0.2
enum34==1.1.10
future==0.18.2
iniconfig==1.1.1
isort==5.10.1
packaging==21.3
pbr==5.9.0
pluggy==1.0.0
psutil==5.9.1
py==1.11.0
pycparser==2.21
pyelftools==0.28
Pygments==2.12.0
pyparsing==3.0.9
pytest
python-ptrace==0.9.8
ROPGadget==6.8
six==1.16.0
testresources==2.0.1
tomli
unicorn==2.0.0" > requirements.txt
./setup.sh
echo "source $PWD/gdbinit.py" > /home/vagrant/.gdbinit

# Installing kflag module
cd /home/vagrant/kflag
sudo make clean
sudo make all
sudo make insmod
mv ./seclab /etc/init.d/seclab
chmod +x /etc/init.d/seclab
chown root:root /etc/init.d/seclab
ln -f -s /etc/init.d/seclab /etc/rc2.d/S50seclab
systemctl daemon-reload
service seclab start

# deploying tutorials
sudo rsync -a /home/vagrant/tuts/ /home/
sudo chown -R vagrant: /home/lab*
sudo cp -f /home/vagrant/seclab /bin/

