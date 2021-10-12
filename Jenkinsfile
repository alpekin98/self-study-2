pipeline {
    agent {
        dockerfile {
            filename "Dockerfile"
            args "--entrypoint=''"
        }
    }
    stages{
        stage("build"){
            steps{
                echo "build"
                sh "make output"
            }
        }
        stage("packaging (debian) & deploying"){
            steps{
                echo "packaging (debian)"
                sh "make make_debian_package"
            }
        }
        stage("docker image"){
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
                sh 'echo "WORKDIR /home" >> Dockerfile'
                sh 'echo "RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "RUN apt-get install ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "CMD helloworld" >> Dockerfile'
                sh 'docker build -t helloworld_image .'
                sh 'docker tag helloworld_image:latest alpekin98/demo-repo'
                sh 'mkdir -p /root/.docker/'
                sh 'cp docker-config/config.json /root/.docker/config.json'
                sh 'docker login'
                sh 'docker push alpekin98/demo-repo'
                sh 'rm helloworld_1.0-1_amd64.deb'
                sh 'docker images'
            }
        }
        stage("registry"){
            steps{
                echo 'registry'
            }
        }
    }
}