pipeline {
    agent any
    options {
        timestamps()
    }
    stages {
        stage("My first stage") {
            steps {
                echo "This is a step in my first stage"
            }
        }
        stage("Print environment variables") {
            steps {
                sh "printenv"
            }
        } 
    }
}