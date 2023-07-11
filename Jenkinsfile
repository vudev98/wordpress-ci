podTemplate {
  node(POD_LABEL) {

    stages {
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