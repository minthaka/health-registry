pipeline {
    agent any

    tools {
        // Must match your Global Tool Configuration name
        maven 'Maven 3.9.12'
    }

    stages {
        stage('Initialize') {
            steps {
                sh 'mvn -version'
            }
        }

        stage('Install Parent POM') {
            steps {
                // -N (non-recursive) is mandatory!
                // It tells Maven: "Don't look for the <modules> folders."
                // install puts the pom.xml into /var/jenkins_home/.m2/repository
                sh 'mvn clean install -N'
            }
        }
    }

    post {
        success {
            echo 'Parent POM is now available for all child projects.'
        }
    }
}