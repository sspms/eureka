#!/usr/bin/env groovy

pipeline {
    agent {
        label 'master'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '50'))
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
        timestamps()
    }
    environment {
        APP_NAME = 'USER'
        SOURCE_JOB = "${JOB_NAME}"
        BUILD_REPO_PATH = "/var/deploy"
    }
    stages {
        stage('Assembly') {
            steps {
                script {
                    withEnv([
                            'MVN_HOME=/usr/maven'
                    ]) {
                        sh """${MVN_HOME}/bin/mvn package"""
                    }
                }
            }
        }

        stage('Copy Assembly to build repo') {
            steps {
                script {
                    def date = new Date().format('yyyyMMddhhmmssSSS')
                    sh """
if [ ! -d ${env.BUILD_REPO_PATH}/eureka ]; then
    mkdir ${env.BUILD_REPO_PATH}/eureka
fi
yes | cp -rf ./target/eureka*.jar ${env.BUILD_REPO_PATH}/eureka/eureka.jar
yes | cp -rf eureka.dockerfile ${env.BUILD_REPO_PATH}/eureka
"""
                    currentBuild.rawBuild.displayName = date
                }
            }
        }
        stage('Build Docker images') {
            when { branch 'master' }
            steps {
                script {
                    echo 'building docker iamges'
                    sh """
"""
                }
            }
            post {
                failure {
                    echo "BUILDING of ${env.APP_NAME} images FAILED !"
                }
            }
        }
        stage('Deployment') {
            when { branch 'master' }
            steps {
                script {
                    echo "Deployment is skipped"
                }
            }
        }
    }
    post {
        failure {
            echo 'pipeline failed'
        }
    }
}