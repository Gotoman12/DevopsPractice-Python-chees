pipeline{
    angent any
    
    environment{
        IMAGE_NAME:'arjunckm/python:${BUILD_NUMER}'
    }
    stages{
        stage("GIT_CHEKKOUT"){
            steps{
                git url:'https://github.com/Gotoman12/DevopsPractice-Python-chees.git',branch:'main'
            }
        }
        stage("build"){
            steps{
                sh 'python3 -m venv venv && source venv/bin/activate'
            }
        }
        stage("docker-build"){
            steps{
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }
        stage("docker-run"){
            steps{
                sh 'docker run -it -d --name python-chess -p 5001:5000 ${IMAGE_NAME}'
            }
        }
         stage("docker-push"){
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