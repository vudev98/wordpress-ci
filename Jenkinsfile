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
    def secrets = [
      [
        path: 'kv-secret/gcloud-credential-key', secretValues: 
        [
          [ envVar: 'GCLOUD_KEY', vaultKey: 'gcloud-key']
        ]
      ]
    ]

    def configuration = [vaultUrl: 'http://34.131.55.105:8200/', vaultCredentialId: 'kv-secret-holder']

    checkout scm

    container('docker'){
      // stage('Initialize'){
      //     def dockerHome = tool 'DockerTool'
      //     env.PATH = "${dockerHome}/bin:${env.PATH}"
      // }

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
        withVault([configuration: configuration, vaultSecrets: secrets]) {
          sh "echo $GCLOUD_KEY"
          sh "gcloud auth activate-service-account 350373098194-compute@developer.gserviceaccount.com --key-file=$GCLOUD_KEY --project=applied-terrain-390603"
        } 

      }

      stage('Get Cluster Config') {
        sh "gcloud container clusters get-credentials cluster-1 --zone asia-south2-a --project applied-terrain-390603"
      }

      stage('Deploy Wordpress') {
        sh "kubectl apply -f ./wordpress-ci/deployment.yaml"
      } 
    }
  }  
}