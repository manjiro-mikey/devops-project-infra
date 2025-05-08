#Update the System
sudo apt update -y && sudo apt upgrade -y

#Install Java
sudo apt install openjdk-21-jdk -y

#Add Jenkins GPG key and Repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

#install Jenkins on Ubuntu 24.04
sudo apt install jenkins -y
sudo systemctl start jenkins && sudo systemctl enable jenkins

# -------------------Install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# sudo install docker.io
# sudo usermod -aG docker jenkins
# sudo usermod -aG root jenkins
# sudo chmod 664 /var/run/docker.sock
#edit visudo
#jenkins ALL=(ALL:ALL) ALL
#jenkins ALL=(ALL) NOPASSWD: ALL

#----------------------install nginx
sudo apt install nginx

#install certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --version

#tao cert cho domain jenkins.devopszero.id.vn
#sudo certbot --nginx

# sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
# echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt-get update
# sudo apt-get install jenkins


#bi loi 403 No valid crumb was included in the request
# => setting securiry -> Enable proxy compatibility

#them  credential dockerhub

#them user jenkins vao root, docker

#1.tao jenkin agent tren server muon trien khai du an connect toi jenkin server
# -> neu khong tao jenkins agent thi co the ssh vao server 
#Mo port tren jenkin server de connect jenkins agent
 # > nohup.out 2>&1 &

#2.connect jenkin server with gitlab
 

#3.tao pipeline tren jenkin server

#4. tao webhook tren gitlab
# 4.1 tao token tren jenkin server: 

# 4.2 tao webhook tren gitlab
# http://jenkins:token@18.141.174.187:8080/project/jenkins