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
                        scp -o StrictHostKeyChecking=no build/libs/teamscal-api-0.0.1-SNAPSHOT.jar jenkins@13.125.241.52:/var/lib/jenkins/app.jar
                        ssh -o StrictHostKeyChecking=no jenkins@13.125.241.52 "
                            pkill -f app.jar || true
                            nohup java -jar /var/lib/jenkins/app.jar --spring.profiles.active=prod > /var/lib/jenkins/app.log 2>&1 &
                        "
                    '''
                }
            }
        }
    }
}