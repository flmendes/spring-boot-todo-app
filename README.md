
## Spring Boot TODO APP

Pet project para estudos de GitOps, Helm e OpenJ9

### Install Jenkins tradicional no cluster Kubernetes
    helm inspect values stable/jenkins > ./jenkins.values

    helm install jenkins stable/jenkins -f jenkins.values

    helm upgrade jenkins stable/jenkins -f jenkins.values

### Como criar a imagem Docker
    docker build . --tag flmendes/spring-boot-app:v2.0.2