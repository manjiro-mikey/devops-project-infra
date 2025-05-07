# 🚀 Project Objective
This project establishes a comprehensive DevOps workflow, encompassing system building, configuration, development, management, and seamless continuous integration with real-world applications

## Architecture for my project
![image](https://github.com/Trourest186/Devops-Project/assets/74035725/c2e59724-41d0-4e5c-950f-359bdab66c85)

# 🛠️ Features
- Using IaC (Terrafom) for preparating AWS cloud architecture
- Ansible is tools which used to configure for machine on AWS to compatiable with conditions
- To demo, I coded a web django simple but this have full basic functions like a real application as front-end, backend, database
- Package application with docker, helm
- High availability with kubernetes, ingress controller, ...
- Build CI/CD use jenkins, and gitlab for storage images, helm chart to deployment, production

# 📋 Usage
- Then git clone my repository, redirect into terrafrom folder, change your key for sources, finally perform the following steps:
  
  ```
  terraform init
  terraform plan
  terraform apply --auto-approve
  ```
- With ansible folder, run yaml files for configuration:
  [instructions can be found in the ansible directory](https://github.com/Trourest186/Devops-Project/tree/master/Ansible)

- The image packaging process or helm chart for kubernetes I have written in the respective folders, and will be used in CI/CD
  
- Preparation two repositories (gitlab), install same as me or different:
  - https://gitlab.com/tgpham26/cd-devops.git for continuous delivery, and continuous deployment
  - https://gitlab.com/tgpham26/ci-devops.git for continuous integration
    
- Configuration webhook, jenkins then start to demo

# 📝 Author
Le Van Dung (Manjiro)
