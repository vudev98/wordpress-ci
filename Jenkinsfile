podTemplate(containers: [
  containerTemplate(
    name: 'docker',
    image: 'docker',
    ttyEnabled: true,
    privileged: true
  ),
  containerTemplate(
    name: 'gcloud',
    image: 'nnvu187/gcloud-sdk:latest',
    ttyEnabled: true,
    privileged: true,
    alwaysPullImage :true
  )]) {
  node(POD_LABEL) {

    checkout scm

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
          sh "docker login --username $user --password $password" 
        }
      }

      stage('Push Wordpress Image') {
        sh "docker push nnvu187/wordpress-custom"
      }
    }

    container('gcloud') {
      stage('Gcloud Authorize') {
        sh "sleep 3000000"
        sh "gcloud auth activate-service-account 350373098194-compute@developer.gserviceaccount.com --key-file=applied-terrain-390603-74569b4dff16.json --project=applied-terrain-390603"
      }

      stage('Deploy Wordpress') {
        sh "kubectl apply -f ./wordpress-ci/deployment.yaml"
      } 
    }
  }  
}