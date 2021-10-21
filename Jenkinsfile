@Library('stage-hooks@main') _

pipeline {
    agent {
        dockerfile {
            filename "Dockerfile"
        }
    }
    stages{
        stage("Importing libraries"){
            steps {
                script {
                    try {
                        sh 'ls -l /'
                        library 'stage-hooks-notexists@main'
                    } catch (error){
                        echo "stage-hooks-notexists@main not found."
                        echo 'Error: ' + error.getMessage()
                    }
                }
            }
        }
        stage("Pre-Build Stage"){
            steps {
                preBuild()
            }
        }
        stage("Build"){
            agent {
                dockerfile {
                    filename "Dockerfile_gtest"
                }
            }
            steps {
                echo "Build stage started."
                sh "make --file=Makefile_debian build"
            }
        }
        stage("Post-Build Stage"){
            steps {
                postBuild()
            }
        }
        stage("Pre-Test Stage"){
            steps {
                preTest()
            }
        }
        stage("Test Stage"){
            agent {
                dockerfile {
                    filename "Dockerfile_gtest"
                }
            }
            steps {
                echo "Test Stage"
                sh 'ls'
                sh 'cmake CMakeLists.txt'
                sh 'make'
                sh './runTests'
            }
        }
        stage("Post-Test Stage"){
            steps {
                postTest()
            }
        }
        stage("Pre-Dist Stage"){
            steps {
                preDist()
            }
        }
        stage("Dist Stage"){
            steps{
                echo "packaging (debian)"
                sh "make --file=Makefile_debian make_debian_package"
            }
        }
        stage("Post-Dist Stage"){
            steps {
                postDist()
            }
        }
        stage("docker image"){
            // agent any
            steps{
                echo "docker image"
                script {
                    try{
                        sh 'service docker start'
                    } catch (error) {
                        echo 'Error: ' + error.getMessage()
                    }
                }
                sh 'rm -f Dockerfile'
                sh 'touch Dockerfile'
                sh 'echo "FROM ubuntu:latest" >> Dockerfile'
                sh 'echo "USER root" >> Dockerfile'
                sh 'echo "RUN apt-get update" >> Dockerfile' 
                sh 'echo "RUN apt-get install curl -y" >> Dockerfile' 
                sh 'echo "RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "RUN apt-get install ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "CMD helloworld" >> Dockerfile'
                sh 'docker build -t helloworld_image .'
                sh 'docker tag helloworld_image:latest alpekin98/demo-repo'
                sh 'mkdir -p /root/.docker/'
                sh 'cp docker-config/config.json /root/.docker/config.json'
                sh 'docker login'
                sh 'docker push alpekin98/demo-repo'
                sh 'docker rmi alpekin98/demo-repo'
                sh 'docker rmi helloworld_image'
                sh 'rm helloworld_1.0-1_amd64.deb'
                sh 'docker images'
            }
        }
    }
}