@Library("Shared") _
pipeline {
    agent any

    environment {
        SCANNER_HOME = tool "sonar"
    } 

    // if someone will not add tag during build and push then pipeline failed
    parameters {
        string(name: "FRONTEND_DOCKER_TAG", defaultValue: "", description: "Setting docker image for latest push")
        string(name: "BACKEND_DOCKER_TAG", defaultValue: "", description: "Setting docker image for latest push")
    }
    stages {
        stage("Validate Parameter") {
            steps {
                script {
                    if (params.FRONTEND_DOCKER_TAG == "" || params.BACKEND_DOCKER_TAG == "") {
                        error("FRONTEND_DOCKER_TAG and BACKEND_DOCKER_TAG must be provided")
                    }
                }
            }
        }

        stage("Clean Workspace") {
            steps {
                script {
                    workspace_cleanup()
                }
            }
        }
        stage ("Git Checkout") {
            steps {
                script {
                    code_checkout("main" , "https://github.com/abhi-kr07/wanderlust.git" )
                }
            }
        }

        stage("Trivy FileSystem scan") {
            steps {
                script {
                    trivy_fs_scan()
                }
            }
        }

        // stage("OWASP Dependency check") {
        //     steps {
        //         script {
        //             owasp_dependency("OWASP")
        //         }
        //     }
        // }

        stage("Sonarqube Code Analysis") {
            steps {
                script {
                    sonarqube_codeanalysis("sonar-server" , "wanderlust-app" , "wanderlust-app")
                }
            }
        }

        stage("Sonarqube Code quality") {
            steps {
                script {
                    sonarqube_codequality()
                }
            }
        }

        stage("Exporting environment variable") {
            parallel {
                stage("Backend") {
                    steps {
                        script {
                            dir("IP_update_automation") {
                                sh "bash updatebackend.sh>"
                            }
                        }
                    }
                }

                stage("Frontend") {
                    steps {
                        script {
                            dir("IP_update_automation") {
                                sh "bash frontend.sh"
                            }
                        }
                    }
                }
            }
            
        }

        stage("Build Image") {
            steps {
                script {
                    dir("backend") {
                        docker_build("wanderlust-app-backend" , "${params.BACKEND_DOCKER_TAG}")
                    }
                    dir("frontend") {
                        docker_build("wanderlust-app-frontend" , "${params.FRONTEND_DOCKER_TAG}")
                    }
                }
            }
        }

        stage("Push Image") {
            steps {
                script {
                    docker_push("wanderlust-app-backend" , "${params.BACKEND_DOCKER_TAG}" , "abhishekk4" , "docker")
                    docker_push("wanderlust-app-frontend" , "${params.FRONTEND_DOCKER_TAG}" , "abhishekk4" , "docker")
                }
            }
        }
    }
    
    // there will be CD pipeline and this will invoke it

    post {
        success{
            archiveArtifacts artifacts: '*.xml', followSymlinks: false
            build job: "Wanderlust-CD", parameters: [
                string(name: 'FRONTEND_DOCKER_TAG', value: "${params.FRONTEND_DOCKER_TAG}"),
                string(name: 'BACKEND_DOCKER_TAG', value: "${params.BACKEND_DOCKER_TAG}")
            ]
        }
    }
}