pipeline {
    agent any
    stages{
        stage("prepare development environment"){
            steps{
                sh "apt-get update -y"
                sh "apt-get install make"
                sh "apt-get install g++ -y"
            }
        }
        stage("build"){
            steps{
                echo "build"
                sh "which make"
                sh "make"
            }
        }
        stage("packaging (debian)"){
            steps{
                echo "packaging (debian)"
                sh "mkdir -p helloworld_1.0-1_amd64/usr/local/bin"
                sh "cp output helloworld_1.0-1_amd64/usr/local/bin"
                sh "mkdir -p helloworld_1.0-1_amd64/DEBIAN"
                sh "touch helloworld_1.0-1_amd64/DEBIAN/control"
                sh "echo 'Package: helloworld' > helloworld_1.0-1_amd64/DEBIAN/control"
                sh "echo 'Version: 1.0' > helloworld_1.0-1_amd64/DEBIAN/control " 
                sh "echo 'Architecture: amd64' > helloworld_1.0-1_amd64/DEBIAN/control " 
                sh "echo 'Maintainer: Arinc Alp Eren <arinc.alp.98@gmail.com>' > helloworld_1.0-1_amd64/DEBIAN/control " 
                sh "echo 'Description: A program that greets you.' > helloworld_1.0-1_amd64/DEBIAN/control " 
                sh "dpkg-deb --build --root-owner-group helloworld_1.0-1_amd64"
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