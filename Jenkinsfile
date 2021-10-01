pipeline {
    agent any
    stages{
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
                sh "mkdir helloworld_1.0-1_amd64/DEBIAN"
                sh "touch helloworld_1.0-1_amd64/DEBIAN/control"
                sh "echo 'Package: helloworld
Version: 1.0
Architecture: amd64
Maintainer: Arinc Alp Eren <arinc.alp.98@gmail.com>
Description: A program that greets you.
You can add a longer description here. Mind the space at the beginning of this paragraph.' > helloworld_1.0-1_amd64/DEBIAN/control"
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