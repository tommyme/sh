# install docker
apt-get update
sudo apt install apt-transport-https ca-certificates dirmngr
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -
echo 'deb https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian/ buster stable' | sudo tee /etc/apt/sources.list.d/docker.list

apt-get update
sudo apt install docker-ce
service docker start


# configure mirror
sudo mkdir -p /etc/docker

read -p "whether change source:(y/n)" change_source

if [[ ${change_source} == "y" ]]
then
	sudo tee /etc/docker/daemon.json <<-'EOF'
	{
	  "registry-mirrors": ["https://xdm99afm.mirror.aliyuncs.com"]
	}
	EOF
else
	echo "source not changed"
fi	
sudo systemctl daemon-reload
sudo systemctl restart docker


# install portainer
read -p "whether install portainer:(y/n)" install_portainer
if [[ ${install_portainer} == "y" ]]
then
	sudo docker run -d -p 9000:9000 -p 8000:8000 \
	-v /var/run/docker.sock:/var/run/docker.sock \
	--restart unless-stopped \
	--name portainer portainer/portainer-ce
else
	echo "portainer not installed"
fi


# install netdata
read -p "whether install netdata:(y/n)" install_netdata
if [[ ${install_netdata} == "y" ]]
then
	sudo docker run -d --name=netdata \
	  -p 19999:19999 \
	  -v netdataconfig:/etc/netdata \
	  -v netdatalib:/var/lib/netdata \
	  -v netdatacache:/var/cache/netdata \
	  -v /etc/passwd:/host/etc/passwd:ro \
	  -v /etc/group:/host/etc/group:ro \
	  -v /proc:/host/proc:ro \
	  -v /sys:/host/sys:ro \
	  -v /etc/os-release:/host/etc/os-release:ro \
	  --restart unless-stopped \
	  --cap-add SYS_PTRACE \
	  --security-opt apparmor=unconfined \
	  netdata/netdata
else
	echo "netdata not installed"
fi

