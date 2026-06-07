# 🚀 Project Objective
This project establishes a comprehensive DevOps workflow, encompassing system building, configuration, development, management, and seamless continuous integration with real-world applications

## Architecture for my project
![image](https://github.com/manjiro-mikey/devops-project-app/blob/master/Resume-Site-Django/assets/architecture%20.png?raw=true)

# 🛠️ Features
- Using IaC (Terrafom) for preparating AWS cloud architecture
- Ansible is tools which used to configure for machine on AWS to compatiable with conditions
- To demo, I coded a web django simple but this have full basic functions like a real application as front-end, backend, database
- Package application with docker, helm
- High availability with kubernetes, ingress controller, ...
- Build CI/CD use jenkins, and gitlab for storage images, helm chart to deployment, production

# 📋 Usage
1. Có thể dùng trực tiếp máy window hoặc tạo một server bastion trên aws và thực hiện cài aws cli, terraform, ansible sau đó clone source code về
## Nếu bạn muốn cài nhanh có thể dùng script Executable_files/install_Ansible.sh sau đó cấu hình file key_credentials.sh và chạy lệnh Executable_files/install_Ansible.sh

1.1 Cài package cơ bản
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y git unzip curl wget ca-certificates gnupg lsb-release software-properties-common
1.2 Cài AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install
aws --version
- Cấu hình credential (cách nhanh):
aws configure
- Nhập AWS Access Key ID, AWS Secret Access Key, Default region name (ví dụ ap-southeast-1), output format json.
aws sts get-caller-identity

1.3 Cài Terraform (HashiCorp repo)
  ```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt update -y
sudo apt install -y terraform
terraform -version
  ```
1.4 Cài Ansible

  ```
  sudo apt-add-repository -y ppa:ansible/ansible
  sudo apt update -y
  sudo apt install -y ansible
  ansible --version
  ```  
1.5 Pull repo và chạy theo luồng project

  ```
  git clone <URL_REPO_CUA_BAN>
  cd devops-project-infra
  ```
Chạy Terraform:
cd Terraform
clear file Output_files/creation-time-private-ip.yml và state của terraform trong folder Teraform trước khi chạy lệnh
bash Executable_files/clear.sh
terraform init
terraform plan
terraform apply --auto-approve
Sau đó qua Ansible (nhớ cập nhật Ansible/hosts và copy ssh key):
cd ..
cp Terraform/Devops.pem Ansible/storage/ec2-key.pem
chmod 400 Ansible/storage/ec2-key.pem
cd Ansible
nano hosts #cập nhật ip public của master, worker, jenkins
ansible -i hosts all -m ping
#Cần copy ip private của master và worker vào file trước khi chạy lệnh(có thể đồng bộ lấy ip từ bước chạy teraform phía trước)
ansible-playbook -i hosts k8s-master.yaml
ansible-playbook -i hosts k8s-worker.yaml

Nếu pong bị lỗi thì cần chạy lệnh
ssh-keyscan -H 44.222.248.32 3.86.110.202 3.82.158.85 >> ~/.ssh/known_hosts

clear file Output_files/ creation-time-private-ip.yml trong folder Teraform trước khi chạy lệnh


- Then git clone my repository, redirect into terrafrom folder, change your key for sources, finally perform the following steps:
  
  ```
  terraform init
  terraform plan
  terraform apply --auto-approve
  ```
- With ansible folder, run yaml files for configuration:
  [instructions can be found in the ansible directory](https://github.com/manjiro-mikey/devops-project-infra/tree/master/Ansible)`

Bước theo theo cần truy cập vào server master và worker để chạy init cụm k8s, bước này cũng có thể dùng ansible để cài tự động thay vì phải ssh vào chạy từng file(nhưng muốn chủ động chạy và kiểm soát lỗi thì nên chạy manual)
2.1 Ssh vào master 
2.2 Chạy install_Master.sh 
2.2 sau khi chay file tren không gặp lỗi gì thì tiếp theo cần init cluster
bash master.sh
kiểm tra cụm
kubectl get nodes
2.3 Chạy lệnh để lấy token chuẩn bị cho bước sau join worker vào cụm
sudo kubeadm token create --print-join-command
2.4 ssh vào worker cài các container.io và các công cụ khác cần thiết
bash worker.sh
2.5 chạy lệnh từ bước 2.3 thêm sudo để join worker vào cụm
example: sudo kubeadm join 10.0.1.117:6443 --token 6mt9t8.c3vsjsuumd0sclzn --discovery-token-ca-cert-hash sha256:3bc86c61faa712a3e6749674195d4dd23a0b2d84ab33e6f5c8484d7b4ee7792f 

- The image packaging process or helm chart for kubernetes I have written in the respective folders, and will be used in CI/CD
  
- The repository contains resource app and Jenkinsfile pipeline:
  - https://github.com/manjiro-mikey/devops-project-app

- Configuration webhook, jenkins then start to demo
Cài đặt app và dababase trên cụm k8s
git clone <source_helm>
cd Helm
kubectl create namespace dev
helm upgrade --install -n dev db-mysql mysql
helm upgrade --install -n dev app-django django
kubectl get all -n dev

# 📝 Author
Le Van Dung (Manjiro)
