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
- Then git clone my repository, redirect into terrafrom folder, change your key for sources, finally perform the following steps:
  
  ```
  terraform init
  terraform plan
  terraform apply --auto-approve
  ```
- With ansible folder, run yaml files for configuration:
  [instructions can be found in the ansible directory](https://github.com/manjiro-mikey/devops-project-infra/tree/master/Ansible)`

- The image packaging process or helm chart for kubernetes I have written in the respective folders, and will be used in CI/CD
  
- The repository contains resource app and Jenkinsfile pipeline:
  - https://github.com/manjiro-mikey/devops-project-app
    
- Configuration webhook, jenkins then start to demo

# 📝 Author
Le Van Dung (Manjiro)
