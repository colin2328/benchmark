#!/usr/bin/env bash
set -ex -o pipefail

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
# Install Docker-CE
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker

# Setup NVIDIA package repository and the GPG key
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Remove unnecessary sources
sudo rm -f /etc/apt/sources.list.d/google-chrome.list
sudo rm -f /etc/apt/heroku.list
sudo rm -f /etc/apt/partner.list

sudo apt-get -y update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

sudo apt-get -y install \
  expect-dev

# install git lfs and checkout the blob files
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs=2.13.2
git lfs install
git lfs fetch
git lfs checkout .

sudo pkill -SIGHUP dockerd
