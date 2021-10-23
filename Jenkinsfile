@Library('stage-hooks@main') _

pipeline {

    parameters { 
        string(name: 'DOCKER_REGISTRY', defaultValue: '192.168.55.11:5000', description: 'Registry Adresi') 
        string(name: 'IMAGE_NAME', defaultValue: 'cnramf-coremgr,cnramf-gtpmgr', description: 'Image isimleri') 
        string(name: 'EXECUTABLE_PATH', defaultValue: '/opt/cinar/cnramf-coremgr,/opt/cinar/cnramf-gtpmgr', description: 'Executable Pathler') 
        string(name: 'VERSION', defaultValue: '1.0', description: 'Version Number') 
        string(name: 'REV_NUMBER', defaultValue: '1', description: 'Revision Number') 
        string(name: 'DEB_ARCHITECTURE', defaultValue: 'amd64', description: 'Debin Architecture') 
        string(name: 'FILE_REPO_SERVER', defaultValue: 'TODO', description: 'Repository Server Name') 
    }
    
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
        stage("Pre-Build Stage"){
            steps {
                preBuild()
            }
        }
        stage("Build"){
            steps {
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def imagename = arrImageNames[i]
                            echo "Build stage started for Image: ${imagename}"
                            sh "make --file=Makefile_debian build IMAGE_NAME=${imagename}"
                        }
                    }
                }
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
            steps {
                echo "Test Stage"
                sh 'cmake CMakeLists.txt'
                sh 'make'
                sh "make --file=Makefile_debian test"
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
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def imagename = arrImageNames[i]
                            echo "packaging for Image:${imagename}"
                            sh "make --file=Makefile_debian make_debian_package IMAGE_NAME=${imagename} DEB_ARCHITECTURE=${params.DEB_ARCHITECTURE} REV_NUMBER=${params.REV_NUMBER} VERSION=${params.VERSION}"
                        }
                    }
                }
            }
        }
        stage("Post-Dist Stage"){
            steps {
                postDist()
            }
        }
        stage("docker image"){
            steps{
                sh 'docker --version'
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrExePaths = params.EXECUTABLE_PATH.split(',')
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def path = arrExePaths[i]
                            def imagename = arrImageNames[i]
                            echo "docker image: ${imagename}"
                            sh "rm -f Dockerfile-${imagename}"
                            sh "touch Dockerfile-${imagename}"
                            sh "echo 'FROM ubuntu:xenial' >> Dockerfile-${imagename}"
                            sh "echo 'USER root' >> Dockerfile-${imagename}"
                            sh "echo 'RUN apt-get update' >> Dockerfile-${imagename}"
                            sh "echo 'ADD https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/${imagename}_${params.VERSION}-${params.REV_NUMBER}_${params.DEB_ARCHITECTURE}.deb ./${imagename}_${params.VERSION}-${params.REV_NUMBER}_${params.DEB_ARCHITECTURE}.deb' >> Dockerfile-${imagename}"
                            sh "echo 'RUN apt-get install ./${imagename}_${params.VERSION}-${params.REV_NUMBER}_${params.DEB_ARCHITECTURE}.deb' >> Dockerfile-${imagename}"
                            sh "echo 'CMD ${path}' >> Dockerfile-${imagename}"
                        }
                    }
                    // sh 'echo "RUN apt-get install curl -y" >> Dockerfile' 
                    // sh 'echo "RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                }
                // sh '''echo -e "
                // FROM ubuntu:xenial\n\
                // USER root\n\
                // RUN apt-get update \n\
                // RUN apt-get install curl -y \n\
                // RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb\n\
                // RUN apt-get install ./helloworld_1.0-1_amd64.deb\n\
                // CMD helloworld" >> Dockerfile
                // ARG argExecutablePath=/opt/cinar/nrf/cnrnrf
                // CMD ${argExecutablePath}


                // ARG argExecutablePath=/opt/cinar/amf/cnramf-coremgr
                // ARG argExecutablePath=/opt/cinar/amf/cnramf-ranmgr
                // ARG argExecutablePath=/opt/cinar/amf/cnramf-sbimgr
                // ARG argExecutablePath=/opt/cinar/amf/cnramf-guimgr
                // ARG argExecutablePath=/opt/cinar/amf/cnramf-limgr
                // ARG argExecutablePath=/opt/cinar/amf/cnramf-gtpmgr
                // CMD ${argExecutablePath}

                // docker build -t amf-coremgr:latest --build-arg argExecutablePath="/opt/cinar/amf/cnramf-coremgr" -f Dockerfile-amf .
                // docker build -t amf-coremgr:latest --build-arg argExecutablePath="/opt/cinar/amf/cnramf-ranmgr" -f Dockerfile-amf .

                // '''
                // sh 'docker build -t 192.168.13.33:5000/amf-coremgr:latest --build-arg argExecutablePath="/opt/cinar/amf/cnramf-ranmgr" -f Dockerfile .'
                
                
                
                // sh 'cp docker-config/config.json /root/.docker/config.json'

                // sh 'docker build -t helloworld_image .'
                // sh 'docker tag helloworld_image:latest alpekin98/demo-repo'
                // sh 'mkdir -p /root/.docker/'
                // sh 'cp docker-config/config.json /root/.docker/config.json'
                // sh 'docker login'
                // sh 'docker push alpekin98/demo-repo'
                // sh 'docker rmi alpekin98/demo-repo'
                // sh 'docker rmi helloworld_image'
                // sh 'rm helloworld_1.0-1_amd64.deb'
                // sh 'docker images'
            }
        }
        stage ('build docker image'){
            steps {
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrExePaths = params.EXECUTABLE_PATH.split(',')
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def path = arrExePaths[i]
                            def imagename = arrImageNames[i]
                            sh "docker build -t ${imagename}:${params.VERSION} -f Dockerfile-${imagename} ."
                            sh "docker build -t ${imagename}:latest -f Dockerfile-${imagename} ."
                        }
                    }
                }
            }
        }
        stage ('push2Registry'){
            steps {
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def imagename = arrImageNames[i]
                            sh "docker tag ${imagename}:${params.VERSION} ${params.DOCKER_REGISTRY}/${imagename}:${params.VERSION}"
                            sh "docker tag ${imagename}:latest ${params.DOCKER_REGISTRY}/${imagename}:${params.VERSION}"
                            sh "docker push ${params.DOCKER_REGISTRY}/${imagename}:${params.VERSION}"
                        }
                    }
                }
            }
        }
        stage ('save2file'){
            steps {
                script {
                    if(IMAGE_NAME.contains(',')){
                        def arrImageNames = params.IMAGE_NAME.split(',')
                        for(def i=0; i<arrImageNames.length;i++){
                            def imagename = arrImageNames[i]
                            sh "docker save ${imagename}:${params.VERSION} -o ${imagename}_${params.VERSION}"
                            sh "scp ${imagename}_${params.VERSION} ${params.FILE_REPO_SERVER}:/var/yansilar/${imagename}/${params.VERSION}/"
                            sh "scp Dockerfile-${imagename} ${params.FILE_REPO_SERVER}:/var/yansilar/${imagename}/${params.VERSION}/"
                        }
                    }
                }
            }
        }
    }
}