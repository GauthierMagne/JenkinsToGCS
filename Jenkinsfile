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
    stage("Launching pipeline"){
        sh(script: "curl -X POST   http://35.240.120.116:8080/api/experimental/dags/airflow_test_api/dag_runs   -H 'Cache-Control: no-cache'   -H 'Content-Type: application/json'   -d '{\"conf\":\"{\\\"key\\\":\\\"value\\\"}\"}' ", returnStdout: true)
    }
    stage("Using curl example") {
        script {
            final String url = "http://35.240.120.116:8080/api/experimental/dags/airflow_test_api/dag_runs"
            final String response = sh(script: " curl -X GET $url", returnStdout: true).trim()
            def splitext = response.split(",")
            def indice = 0
            def indiceFinal=0
            def list =[]
            for (item in splitext) {
                if (item =="\"state\":\"success\"}" || item =="\"state\":\"failed\"}" ){
                    list[indice] = item
                    indiceFinal = indice
                    indice = indice+1
                }
                println list[indiceFinal]
            }
        }
    }
}