def printFromFunction() {
    println("I am priting from a function")
}

def replaceString() {
    def text = readFile file: "index.html"
    text = text.replaceAll("%BUILD_NUMBER%", "${BUILD_NUMBER}")
    writeFile file: "index.html", text: text
}

pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                echo "Build"
                printFromFunction()
                replaceString()
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