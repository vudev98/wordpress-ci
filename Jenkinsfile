podTemplate(containers: [
  containerTemplate(
    name: 'docker',
    image: 'docker',
    ttyEnabled: true,
    privileged: true
  )]) {
  node(POD_LABEL) {
    container('docker'){
      stage('Initialize'){
          def dockerHome = tool 'DockerTool'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
      }

      stage('Build Wordpress Image')  {
          sh "docker build -t nnvu187/wordpress-custom ."
      }

      stage("Docker Login") {
        withCredentials([usernamePassword(credentialsId: 'nnvu-dockerhub', usernameVariable: 'user', passwordVariable: 'password' )]) {
          
        sh "echo ${password} | docker login --username $user --password-stdin"
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