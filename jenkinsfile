node{
    def registryProjet = 'awe-marketo-tool/jenkins_test'
    def IMAGE = "${registryProjet}:version-${env.BUILD_ID}"
    stage('git clone') {
        git credentialsId: 'github', url: 'https://github.com/GauthierMagne/JenkinsToGCS.git'
    }
    
    stage('send to GCS'){
         googleStorageUpload bucket: "gs://awe-marketo-tool_cloudbuild/test", credentialsId: 'awe-marketo-tool', pattern: 'dags/*.py'
    }
    def img = stage('Build') {
        docker.build("$IMAGE", '.')
    }
    stage('build'){
        sh label: '', script: ' docker build -t \'dockerjenkingcp:1.0\' .'
    }
    
    stage("docker push") {
        docker.withRegistry('https://eu.gcr.io', "gcr:awe-marketo-tool") {
            img.push("testpush.${env.BUILD_ID}")
        }
    }
}
