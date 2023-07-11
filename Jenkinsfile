pipeline {
environment {
  registry = "nnvu187/wordpress-custom"
  registryCredential = "nnvu-dockerhub"
  dockerImage = ""
} 

  agent any

  stages {
    stage('Build Wordpress Image')  {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      } 
    }

    stage('Deploy Wordpress Image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }

    stage("Clean up") {
      steps {
        script {
          sh "docker rmi $registry:$BUILD_NUMBER"
        }
      }
    }
  }
}