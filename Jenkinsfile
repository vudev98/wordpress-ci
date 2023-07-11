podTemplate {
  node(POD_LABEL) {

    stages {
    
      stage('Build Wordpress Image')  {
        steps {
          sh "docker build -t nnvu187/wordpress-custom ."
        } 
      }

      stage('Push Wordpress Image') {
        steps {
          sh "docker push nnvu187/wordpress-custom"
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
}  