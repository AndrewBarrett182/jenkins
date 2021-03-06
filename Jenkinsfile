@Library("jenkins_shared") _

pipeline {
    agent any
    options {
        timestamps()
        disableConcurrentBuilds()
    }
    environment {
        build_number = "${BUILD_NUMBER}"
        MY_ENV_VAR = "test_env_var"
        // GITHUB = credentials("github") 
    }
    parameters {
        string(name: "Name", defaultValue: "Andrew", description: "Your name")
        text(name: 'DEPLOY_TEXT', defaultValue: 'One\nTwo\nThree\n', description: '')
        booleanParam(name: 'DEBUG_BUILD', defaultValue: true, description: '')
        choice(name: 'CHOICES', choices: ['one', 'two', 'three'], description: '')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'A secret password')
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
                sh "mkdir -p docker"
            }
        }
        stage("Docker Build") {
            agent {
                docker {
                    image "node:latest"
                    args "-v ${WORKSPACE}/docker:/home/node"
                }
            }
            steps {
                sh """
                    node --version > /home/node/docker_node_version
                    npm --version > /home/node/docker_npm_version
                """
            }
        }
        stage("Docker Build w/ Python") {
            agent {
                docker {
                    image "python:latest"
                    args "-v ${WORKSPACE}/docker:/home/python"
                }
            }
            steps {
                sh """
                    python --version > /home/python/docker_python_version
                """
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
        // cleanup {
        //     cleanWs()
        // }
    }
}