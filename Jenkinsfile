@Library("jenkins_shared") _

pipeline {
    agent any
    options {
        timestamps()
    }
    environment {
        build_number = "${BUILD_NUMBER}"
        MY_ENV_VAR = "test_env_var"
    }
    parameters {
        string(name: "Name", defaultValue: "Andrew", description: "Your name")
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
                echo "${MY_ENV_VAR}"
                echo "${params.Name}"
            }
        }
        stage("Test") {
            parallel {
                stage("Test on Windows") {
                    steps {
                        echo "Windows Test"
                        sh "./test.sh ${build_number}"
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
                sshPublisher(publishers: [sshPublisherDesc(configName: 'http', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'mv index.html /var/www/html', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'index.html')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'index.html', followSymlinks: false
        }
        cleanup {
            cleanWs()
        }
    }
}