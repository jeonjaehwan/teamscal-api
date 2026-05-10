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
                sh 'scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa build/libs/teamscal-api-0.0.1-SNAPSHOT.jar jenkins@13.125.241.52:/var/lib/jenkins/app.jar'
                sh 'scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa docker-compose.yml jenkins@13.125.241.52:/var/lib/jenkins/docker-compose.yml'
                sh 'scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa Dockerfile jenkins@13.125.241.52:/var/lib/jenkins/Dockerfile'
                sh '''ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa jenkins@13.125.241.52 << 'EOF'
cd /var/lib/jenkins
docker-compose down
docker-compose up -d --build
EOF'''
            }
        }
    }
}