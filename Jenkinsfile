podTemplate(containers: [
  containerTemplate(
    name: 'docker',
    image: 'docker',
    ttyEnabled: true,
  )],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) {
  node(POD_LABEL) {
    container('docker'){
      stage('Initialize'){
          def dockerHome = tool 'DockerTool'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
      }

      stage("Cloning git repo") {
        git ( 
          branch: 'main',
          credentialsId: 'github-user1',
          url:'https://github.com/vudev98/wordpress-ci-cd.git')
      }

      stage("test docker client") {
        sh "docker -v"
      }

      stage('Build Wordpress Image')  {
          sh "docker build -t nnvu187/wordpress-custom ."
      }

      stage('Push Wordpress Image') {
          sh "docker push nnvu187/wordpress-custom"
      }

      stage("Clean up") {
          sh "docker rmi nnvu187/wordpress-custom:$BUILD_NUMBER"    
      }
    }
  }
}