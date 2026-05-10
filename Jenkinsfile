pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh './gradlew clean build -x test'
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                        scp -o StrictHostKeyChecking=no build/libs/*.jar jenkins@13.125.241.52:/home/jenkins/app.jar
                        ssh -o StrictHostKeyChecking=no jenkins@13.125.241.52 "
                            pkill -f app.jar || true
                            nohup java -jar /home/jenkins/app.jar --spring.profiles.active=prod > /home/jenkins/app.log 2>&1 &
                        "
                    '''
                }
            }
        }
    }
}