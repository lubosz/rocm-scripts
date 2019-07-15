Please read the instruction before proceeding:
---------------------------------------------------
0. Install docker first. Steps are mentioned below.
1.Copy the "Docker-Files" folder to local machine. Su to root user.
2.Based on distros for rocm-master and release, there is *.sh file under each distros folder.
  Run the sh file by passing the arugument.
  Example: for rocm-master : ./*.sh 8318  : for release : ./*.sh 1.8
3. "base" folder is different for different distros for rocm-master and release.
    Kindly Note: For the release base docker images, the default driver repo is internal and 
    you will have to uncomment the lines under “for external repo” & comment out the lines under “for internal repo”  
    to make the default driver repo to external. 
    
4. Base Image Docker File  : fresh Distros + driver either release or rocm-master + mathlibs
   You need to pass nly one gfxip at a time like " echo "gfx900" >> /opt/rocm/bin/target.lst"
   So, you need to edit the base image dokcerfile accordingly.



Docker install, login, pull , push and run
--------------------------------------

1. Sign up on DockerHub 

See here:  https://hub.docker.com/
Then send me your ID -- you'll use this to access the Docker images that we've pushed out to DockerHub.

If Docker is not installed on the system, then do this: 

2. Install Docker

# Get docker-ce 
 for ubuntu16.04 and centos7
==========================================
sudo apt-get -y install apt-transport-https ca-certificates curl  ; for ubuntu
sudo yum -y install apt-transport-https ca-certificates curl  ; for centos
curl -fsSL https://get.docker.com/ | sh ; download the latest version of Docker, and install it
sudo systemctl start docker ; start the Docker daemon:
sudo systemctl status docker ; verify it's running or not [ Active: active (running)]
sudo systemctl enable docker ; make sure it starts at every server reboot

 for rhel7
==========================================
Find your Docker EE repo URL

To install Docker EE, you will need the URL of the Docker EE repository associated with your trial or subscription:

    Go to https://store.docker.com/my-content. All of your subscriptions and trials are listed.
    Click the Setup button for Docker Enterprise Edition for Red Hat Enterprise Linux.
    use 1 month trial version if do not want to purchase it
    Copy the URL from Copy and paste this URL to download your Edition and save it for later use.

You will use this URL in a later step to create a variable called, DOCKERURL.
Set up the repository

switch to root user.

#export DOCKERURL="<DOCKER-EE-URL>" [in this case https://storebits.docker.com/ee/rhel/sub-6df4a838-a037-4124-8f9c-1ce446c36b55]

#sudo -E sh -c 'echo "$DOCKERURL/rhel" > /etc/yum/vars/dockerurl'

#sudo sh -c 'echo "7" > /etc/yum/vars/dockerosversion'

#sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

#sudo yum makecache fast
# sudo yum -y install container-selinux

Install the latest version of Docker EE, or go to the next step to install a specific version:

$ sudo yum -y install docker-ee

sudo systemctl start docker

===========================================================


4. sudo adduser $LOGNAME docker



5.Log in to Docker

sudo docker login
username : rocmqa -> for rocm-master
           computecqe -> rocm release
Password: AH64_uh1

6.push docker image to docker hub
#sudo docker tag <imageid> rocmqa/tf13-centos75:1.8.2RC2
#docker push rocmqa/tf13-centos75:1.8.2RC2

7.Pull the image
docker pull rocmqa/tf13-centos75:1.8.2RC2

8.Run the container
docker run -it --rm --network=host --privileged --device=/dev/kfd --group-add video -v $HOME/dockerx:/dockerx <imageid>

9. Docker images and containers clean up
============================================
remove docker images
------------------------------
how-to-remove-old-and-unused-docker-images

$ docker images
$ docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

$ docker images | grep "none"
$ docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')

remove docker containers
-------------------------------
how-to-remove-old-and-unused-docker-images
$ docker ps
$ docker ps -a
$ docker rm $(docker ps -qa --no-trunc --filter "status=exited")
