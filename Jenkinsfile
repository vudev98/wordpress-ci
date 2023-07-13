podTemplate(containers: [
  containerTemplate(
    name: 'docker',
    image: 'docker',
    ttyEnabled: true,
    privileged: true
  ),
  containerTemplate(
    name: 'unix',
    image: 'bitnami/kubectl'
  )]) {
  node(POD_LABEL) {
    container('docker'){
      stage('Initialize'){
          def dockerHome = tool 'DockerTool'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
      }

      stage('Checkout SCM') {
        checkout scm
      }

      stage('Build Wordpress Image')  {
          sh "docker build -t nnvu187/wordpress-custom ."
      }

      stage("Docker Login") {
        withCredentials([usernamePassword(credentialsId: 'nnvu-dockerhub', usernameVariable: 'user', passwordVariable: 'password' )]) {
          sh "docker login --username $user --password $password" 
        }
      }

      stage('Push Wordpress Image') {
        sh "docker push nnvu187/wordpress-custom"
      }
    }

    stage('Deploy') {
      container('unix') {
        sh "cd ./wordpress-ci && kubectl apply -f ."
      }
    }
  }
}