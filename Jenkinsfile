@Library("jenkins_shared") _

pipeline {
    agent any
    options {
        timestamps()
    }
    stages {
        stage("Build") {
            steps {
                echo "Build"
                hello() 
                helloVariable("Andrew")
                script {
                    utils.printFromFunction()
                    utils.replaceString()
                }
            }
        }
        stage("Test") {
            parallel {
                stage("Test on Windows") {
                    steps {
                        echo "Windows Test"
                        script {
                            sh "cat index.html | grep 'Deployed by Jenkins job: ${BUILD_NUMBER}'"
                            // def file = "index.html"
                            // if (file.count("%BUILD_NUMBER%") == 0) {
                            //     echo "great success"
                            // }
                        }
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