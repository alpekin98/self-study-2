@Library('stage-hooks@main') _

pipeline {
    agent {
        dockerfile {
            filename "Dockerfile"
            args "-v /var/run/docker.sock:/var/run/docker.sock"
        }
    }
    stages{
        stage("Importing libraries"){
            steps {
                script {
                    try {
                        library 'stage-hooks-notexists@main'
                    } catch (error){
                        echo "stage-hooks-notexists@main not found."
                        echo 'Error: ' + error.getMessage()
                    }
                }
            }
        }
        // önce dockerfile build edilir, sonra container "master:volume>agent_docker_container:volume" yaratılır 
        // git clone -> masterdan paylaşılan volume içinde yapılır
        // Her sh komutu agent_docker_container içinde çalışır
        // make, test, deb build (xxx.deb), -> agent_docker_container
        // docker build -> master jenkins içinde /volume/{xxx.deb, Dockerfile-artifact}
        // docker build -t xxx_image -f Dockerfile-artifact .
        // stage("Clone"){
        //      git branch: "${params.YAML_BRANCH_NAME}", credentialsId: "${NF_REPO_CRED_ID}", url: "${params.YAML_REPO_URL}"
        // }
        // stage("create docker director"){
        //     dir("docker_art"){
        //         sh "cp xxx.deb"
        //         sh "cp Dockerfile-artifact"
        //         sh "docker build"
        //     }
        // }
        // stage("BBB"){
        //     docker.withEnv( DOCKER_HOST: "tcp://internal.docker.host:2375"){
        //         docker.build()
        //     }
        // }
        stage("Pre-Build Stage"){
            steps {
                preBuild()
            }
        }
        stage("Build"){
            // agent {
            //     dockerfile {
            //         filename "Dockerfile_gtest"
            //     }
            // }
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
            // agent {
            //     dockerfile {
            //         filename "Dockerfile_gtest"
            //     }
            // }
            steps {
                echo "Test Stage"
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
                sh 'docker --version'
                // script {
                //     try{
                //         sh 'service docker start'
                //     } catch (error) {
                //         echo 'Error: ' + error.getMessage()
                //     }
                // }
                sh 'rm -f Dockerfile'
                sh 'touch Dockerfile'
                sh 'echo "FROM ubuntu:xenial" >> Dockerfile'
                sh 'echo "USER root" >> Dockerfile'
                sh 'echo "RUN apt-get update" >> Dockerfile' 
                sh 'echo "RUN apt-get install curl -y" >> Dockerfile' 
                sh 'echo "RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "RUN apt-get install ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "CMD helloworld" >> Dockerfile'
                // sh 'docker build -t helloworld_image .'
                // def artifactImage = docker.build("helloworld_image")
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