@Library('stage-hooks@main') _

pipeline {

    parameters { 
        string(name: 'DOCKER_REGISTRY', defaultValue: '192.168.13.33:5000', description: 'Registry Adresi') 
        string(name: 'IMAGE_NAME', defaultValue: 'cnramf-coremgr,cnramf-gtpmgr', description: 'Image isimleri') 
        string(name: 'EXECUTABLE_PATH', defaultValue: '/opt/cinar/cnramf-coremgr,/opt/cinar/cnramf-gtpmgr', description: 'Executable Pathler') 
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
        // önce dockerfile build edilir, sonra container "master:volume>agent_docker_container:volume" yaratılır 
        // git clone -> masterdan paylaşılan volume içinde yapılır
        // Her sh komutu agent_docker_container içinde çalışır
        // make, test, deb build (xxx.deb), -> agent_docker_container
        // docker build -> master jenkins içinde /volume/{xxx.deb, Dockerfile-artifact}
        // docker build -t xxx_image -f Dockerfile-artifact .
        stage("Pre-Build Stage"){
            steps {
                preBuild()
            }
        }
        stage("Build"){
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
            steps{
                echo "docker image"
                sh 'docker --version'
                sh 'rm -f Dockerfile'
                sh 'touch Dockerfile'
                sh 'echo "FROM ubuntu:xenial" >> Dockerfile'
                sh 'echo "ARG argExecutablePath=${EXECUTABLE_PATH}" >> Dockerfile'
                sh 'echo "USER root" >> Dockerfile'
                sh 'echo "RUN apt-get update" >> Dockerfile' 
                // sh 'echo "RUN apt-get install curl -y" >> Dockerfile' 
                // sh 'echo "RUN curl https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb --output ./helloworld_1.0-1_amd64.deb" >> Dockerfile'
                sh 'echo "ADD https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/${IMAGE_NAME}_${VERSION}-${REV_NUMBER}_${DEB_ARCHITECTURE}.deb ./${IMAGE_NAME}_${VERSION}-${REV_NUMBER}_${DEB_ARCHITECTURE}.deb" >> Dockerfile'
                sh 'echo "RUN apt-get install ./${IMAGE_NAME}_${VERSION}-${REV_NUMBER}_${DEB_ARCHITECTURE}.deb" >> Dockerfile'
                sh 'echo "CMD ${EXECUTABLE_PATH}" >> Dockerfile'
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
                sh 'docker build -t ${params.IMAGE_NAME}:${VERSION} --build-arg argExecutablePath="${EXECUTABLE_PATH}" -f Dockerfile-${IMAGE_NAME} .'
                sh 'docker build -t ${IMAGE_NAME}:latest --build-arg argExecutablePath="${EXECUTABLE_PATH}" -f Dockerfile-${IMAGE_NAME} .'
            }
            // if(IMAGE_NAME.contains(',')){
            //     def arrExePaths = params.EXECUTABLE_PATH.split(',')
            //     def arrImageNames = params.IMAGE_NAME.split(',')
            //     for(def i=0; i<arrImageNames.lenght;i++){
            //         def path = arrExePaths[i]
            //         def imagename = arrImageNames[i]
            //         sh 'docker build -t ${imagename}:${VERSION} --build-arg argExecutablePath="${path}" -f Dockerfile-${imagename} .'
            //         sh 'docker build -t ${IMAGE_NAME}:latest --build-arg argExecutablePath="${path}" -f Dockerfile-${IMAGE_NAME} .'                        
            //     }
            // }
        }
        stage ('push2Registry'){
            steps {
                sh 'docker tag ${IMAGE_NAME}:${VERSION} ${params.DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION}'
                sh 'docker tag ${IMAGE_NAME}:latest ${params.DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION}'
                sh 'docker push ${params.DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION}'
            }
        }
        stage ('save2file'){
            steps {
                sh 'docker save ${IMAGE_NAME}:${VERSION} -o ${IMAGE_NAME}_${VERSION}'
                sh 'scp ${IMAGE_NAME}_${VERSION} ${FILE_REPO_SERVER}:/var/yansilar/${IMAGE_NAME}/${VERSION}/'
                sh 'scp Dockerfile-${IMAGE_NAME} ${FILE_REPO_SERVER}:/var/yansilar/${IMAGE_NAME}/${VERSION}/'
            }
        }
    }
}