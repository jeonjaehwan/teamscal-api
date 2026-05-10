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
        sh 'ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa jenkins@13.125.241.52 "pkill -f app.jar || true"'
        sh 'ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa jenkins@13.125.241.52 "nohup java -jar /var/lib/jenkins/app.jar --spring.profiles.active=prod > /var/lib/jenkins/app.log 2>&1 &"'
    }
}
    }
}