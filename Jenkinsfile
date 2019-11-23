def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
//   containerTemplate(name: 'gradle', image: 'gradle:4.5.1-jdk9', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'maven', image: 'maven:3.6.0-jdk-8-alpine', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true),
],
volumes: [
  hostPathVolume(mountPath: '/home/maven/.gradle', hostPath: '/tmp/jenkins/.maven'),
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
    def chart_dir = "${pwd}/helm/spring-boot-todo-app"
    def myRepo = checkout scm
    def gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH
    def shortGitCommit = "${gitCommit[0..10]}"
    def previousGitCommit = sh(script: "git rev-parse ${gitCommit}~", returnStdout: true)

    // stage ('test deployment') {

    //   container('helm') {

    //     // run helm chart linter
    //     pipeline.helmLint(chart_dir)

    //     // run dry-run helm chart installation
    //     pipeline.helmDeploy(
    //       dry_run       : true,
    //       name          : config.app.name,
    //       namespace     : config.app.name,
    //       chart_dir     : chart_dir,
    //       set           : [
    //         "imageTag": image_tags_list.get(0),
    //         "replicas": config.app.replicas,
    //         "cpu": config.app.cpu,
    //         "memory": config.app.memory,
    //         "ingress.hostname": config.app.hostname,
    //       ]
    //     )

    //   }
    // }
 
    stage('Test') {
      try {
        // container('gradle') {
        //   sh """
        //     pwd
        //     echo "GIT_BRANCH=${gitBranch}" >> /etc/environment
        //     echo "GIT_COMMIT=${gitCommit}" >> /etc/environment
        //     gradle test
        //     """
        // }
        container('maven') {
          sh 'mvn -B test'
        }
      }
      catch (exc) {
        println "Failed to test - ${currentBuild.fullDisplayName}"
        throw(exc)
      }
    }
    stage('Build') {
    //   container('gradle') {
    //     sh "gradle build"
    //   }
        container('maven') {
          sh 'mvn -B clean compile'
        }

    }
    stage('Run kubectl') {
      container('kubectl') {
        sh "kubectl get pods"
      }
    }
    stage('Run helm') {
      container('helm') {
        sh "helm list"
      }
    }
  }
}