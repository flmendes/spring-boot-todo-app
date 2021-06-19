
## Spring Boot TODO APP

Pet project para estudos de GitOps, Helm e OpenJ9

### Como criar a imagem Docker
    docker build . --tag flmendes/spring-boot-app:v2.0.2

### Como criar uma JVM customizada
    jlink --add-modules java.base,java.compiler,java.instrument,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,jdk.jconsole,jdk.unsupported --compress 2 --no-header-files --no-man-pages --output target/runtime-image

### Como publicar uma imagem no docker hub
    docker build .  --tag flmendes/spring-boot-app:v2.1.0

### Como publicar uma imagem no docker registry ibm cloud
    docker tag flmendes/spring-boot-app:v2.1.0 de.icr.io/station/spring-boot-app:v2.1.0
    docker push de.icr.io/station/spring-boot-app:v2.1.0
#### Antes de executar o comando acima verifique qual o container registry você está logado
    ibmcloud cr login
    ibmcloud cr namespace-add <my_namespace>

#### Como recuperar o IP publico do cluster
    ibmcloud ks worker ls --cluster <ID_CLUSTER>
  