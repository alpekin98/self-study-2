pipeline {
    agent any
    stages{
        stage("build"){
            steps{
                echo "build"
                make
            }
        }
        stage("packaging (debian)"){
            steps{
                echo "packaging (debian)"
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