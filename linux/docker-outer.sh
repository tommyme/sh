# install docker
curl -fsSL https://get.docker.com | bash -s docker


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


# install nps
read -p "whether install nps:(y/n)" install_nps

if [[ ${install_nps} == "y" ]]
then
	read -p "prepare ~/nps/conf first!" temp
	sudo docker run -d --name nps --net=host \
	  -v ~/nps/conf:/conf \
	  ffdfgdfg/nps
else
	echo "netdata not installed"
fi

