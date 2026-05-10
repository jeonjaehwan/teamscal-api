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
                sh '''
                    pkill -f teamscal-api || true
                    nohup java -jar build/libs/*.jar --spring.profiles.active=prod > app.log 2>&1 &
                '''
            }
        }
    }
}