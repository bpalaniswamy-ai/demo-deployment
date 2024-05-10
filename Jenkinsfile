node{
    def WORKSPACE = "/var/lib/jenkins/workspace/demo-deployment"
    def dockerImageTag = "demo-deployment${env.BUILD_NUMBER}"

    try{
        stage('Clone Repo'){

            git url : 'https://github.com/bpalaniswamy-ai/demo-deployment',
                credentialsId : 'deployment-admin',
                branch: 'main'
        }

        stage('Build Docker'){
            dockerImage = docker.build("demo-deployment:${env.BUILD_NUMBER}")
        }

        stage('deploy Docker'){
            echo 'Docker Image Tag Name: ${dockerImageTag}'

            sh "docker stop demo-deployment || true && docker rm demo-deployment || true"

            sh "docker run --name demo-deployment -d -p 9000:9000 demo-deployment:S{env.BUILD_NUMBER}"
        }


    }catch(e){
        throw e
    }

def notifyBuild(String buildStatus = 'STARTED'){

        // build status of null means successful
          buildStatus =  buildStatus ?: 'SUCCESSFUL'
          // Default values
          def colorName = 'RED'
          def colorCode = '#FF0000'
          def now = new Date()
          // message
          def subject = "${buildStatus}, Job: ${env.JOB_NAME} FRONTEND - Deployment Sequence: [${env.BUILD_NUMBER}] "
          def summary = "${subject} - Check On: (${env.BUILD_URL}) - Time: ${now}"
          def subject_email = "Spring boot Deployment"
          def details = """<p>${buildStatus} JOB </p>
            <p>Job: ${env.JOB_NAME} - Deployment Sequence: [${env.BUILD_NUMBER}] - Time: ${now}</p>
            <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}</a>"</p>"""


          // Email notification
            emailext (
                 to: "admin@gmail.com",
                 subject: subject_email,
                 body: details,
                 recipientProviders: [[$class: 'DevelopersRecipientProvider']]
               )
        }

}