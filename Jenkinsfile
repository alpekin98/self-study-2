pipeline {
    agent any
    stages{
        stage("prepare development environment"){
            steps{
                echo "prepare development environment"
            }
        }
        stage("build"){
            steps{
                echo "build"
                sh "make"
            }
        }
        stage("packaging (debian)"){
            steps{
                echo "packaging (debian)"
                sh "rm -rf helloworld_1.0-1_amd64"
                sh "mkdir -p helloworld_1.0-1_amd64/usr/local/bin"
                sh "cp helloworld helloworld_1.0-1_amd64/usr/local/bin"
                sh "mkdir -p helloworld_1.0-1_amd64/DEBIAN"
                sh "touch helloworld_1.0-1_amd64/DEBIAN/control"
                sh "echo 'Package: helloworld' >> helloworld_1.0-1_amd64/DEBIAN/control"
                sh "echo 'Version: 1.0' >> helloworld_1.0-1_amd64/DEBIAN/control" 
                sh "echo 'Architecture: amd64' >> helloworld_1.0-1_amd64/DEBIAN/control" 
                sh "echo 'Maintainer: Arinc Alp Eren <arinc.alp.98@gmail.com>' >> helloworld_1.0-1_amd64/DEBIAN/control" 
                sh "echo 'Description: A program that greets you.' >> helloworld_1.0-1_amd64/DEBIAN/control" 
                sh "dpkg-deb --build --root-owner-group helloworld_1.0-1_amd64"
                sh "make clean"
                sh "dpkg -i helloworld_1.0-1_amd64.deb"
                sh "rm -rf helloworld_1.0-1_amd64"
                sh "rm helloworld_1.0-1_amd64.deb"
                sh "helloworld"
            }
        }
        stage("docker image"){
            steps{
                echo "docker image"
            }
        }
        stage("registry"){
            steps{
                echo "registry"
            }
        }
    }
}