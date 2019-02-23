# seed-node

make sure port 6666 is open

if you have less than 2gb of ram, run this:

`sudo dd if=/dev/zero of=swapfile bs=1M count=3000 && sudo mkswap swapfile && sudo chmod 0600 swapfile && sudo swapon swapfile`

### to run the seed node:

#### install docker

`sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common vim && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update && sudo apt-get install -y docker-ce`

#### clone repo

`git clone https://github.com/raven-dark/seed-node.git && cd seed-node`

#### build the docker image

`sudo docker build -t xrd .`

#### run the docker image container

`sudo docker run -d -p 6666:6666 -v ~/data:/root/data --name xrd xrd:latest`
