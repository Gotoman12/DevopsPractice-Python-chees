pipeline{
    agent any
    
    environment{
        IMAGE_NAME="arjunckm/python:${GIT_COMMIT}"
    }
    stages{
        stage("GIT_CHEKKOUT"){
            steps{
                git url:'https://github.com/Gotoman12/DevopsPractice-Python-chees.git',branch:'main'
            }
        }
        stage("docker-build"){
            steps{
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }
        stage("docker-run"){
            steps{
                sh '''
                docker kill python-chess
                docker rm python-chess
                docker run -it -d --name python-chess -p 6001:5000 ${IMAGE_NAME}'
                '''
            }
        }
         stage("docker-cred"){
            steps{
                script {
                   withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Login to Docker Hub
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                 }
                }
            }
        }
        stage("docker-push"){
            steps{
                sh 'docker push ${IMAGE_NAME}'
            }
        }
    }
}