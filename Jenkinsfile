pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                echo "Build"
            }
        }
        stage("Test") {
            parallel {
                stage("Test on Windows") {
                    steps {
                        echo "Windows Test"
                    }
                }
                stage("Test on Linux") {
                    steps {
                        echo "Linux Test"
                    }
                }
            }
        }
        stage("Deploy") {
            steps {
                echo "Deploy"
            }
        }
    }
}