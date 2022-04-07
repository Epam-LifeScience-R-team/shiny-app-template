pipeline {
    agent {
        dockerfile true
    }
    options {
        // disableConcurrentBuilds()
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }
    stages {
        stage ('Checkout') {
            steps  {
                echo 'Checking out repo...'
                checkout scm
                export_git_info()
                echo "GIT_USERNAME: ${env.GIT_USERNAME}"
                echo "GIT_MESSAGE: ${env.GIT_MESSAGE}"
                echo "GIT_HASH: ${env.GIT_HASH}"
            }
        }
        stage('Restore working environment') {
            steps {
                sh '''
                    R --vanilla -e "Sys.info()[['user']]"
                    R --vanilla -e "renv::settings\\$use.cache(FALSE)"
                    R --vanilla -e "renv::restore()"
                '''
            }
        }
        stage('Testing and Deployment') {
            stages {
                stage('Syntax Check') {
                    steps {
                        script {
                            try {
                                echo "Testing Syntax..."
                                sh '''
                                    Rscript dev/run-lintr.R
                                '''
                            }
                            catch (Exception e) {
                                echo "Syntax checking failed!"
                                currentBuild.result = 'UNSTABLE'
                            }
                        }
                    }
                }
                stage('Testing') {
                    steps {
                        echo "Running Tests"
                        sh '''
                            R --vanilla -e "shiny::runTests()"
                        '''
                    }
                }
                stage('Deployment') {
                    when {
                        anyOf { branch 'develop'; branch 'master'; }
                    }
                    environment {
                        DEPLOYMENT_ENV = sh(returnStdout: true, script: 'if [[ $ENV == "master" ]]; then echo "prd"; else  echo "dev"; fi')
                    }
                    steps {
                        echo "DEPLOYMENT ENVIRONMENT: ${DEPLOYMENT_ENV}"
                        echo "BRANCH_NAME: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
            deleteDir()
        }
        success {
            echo 'SUCCESS'
        }
        unstable {
            echo 'UNSTABLE'
        }
        failure {
            echo 'FAILURE'
        }
        changed {
            echo 'CHANGED'
        }
    }
}

def export_git_info() {
    env.GIT_USERNAME = sh(returnStdout: true, script: 'git show -s --pretty=format:%an')
    env.GIT_MESSAGE = sh(returnStdout: true, script: 'git show -s --pretty=format:%s')
    env.GIT_HASH = sh(returnStdout: true, script: 'git log -1 --pretty=format:%H')
}