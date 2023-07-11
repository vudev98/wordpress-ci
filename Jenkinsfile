podTemplate {
  node(POD_LABEL) {
    withEnv([
      "REGISTRY=nnvu187/wordpress-custom",
      "REGISTRYCREDENTIAL=nnvu-dockerhub",
      "DOCKERIMAGE=''"
    ])

    stages {
    
      stage('Build Wordpress Image')  {
        steps {
          script {
            ${DOCKERIMAGE} = docker.build ${REGISTRY} + ":$BUILD_NUMBER"
          }
        } 
      }

      stage('Deploy Wordpress Image') {
        steps {
          script {
            docker.withRegistry( '', ${REGISTRYCREDENTIAL} ) {
            ${DOCKERIMAGE}.push()
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
}  