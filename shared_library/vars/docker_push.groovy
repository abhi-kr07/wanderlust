def call(String ProjectName , String ImageTag , DockerhubUser , String DockerID) {
    withCredentails([usernamePassword](credentialsId: "${DockerID}" , passwordVariable: "DockerhubPass" , usernameVariable: "DockerhubUser"))
        sh "docker login -u ${DockerhubUser} -p ${DockerhubPass}"
    }
    sh "docker tag ${ProjectName}:${ImageTag} ${DockerhubUser}/${ProjectName}:${ImageTag}"
    sh "docker push ${DockerhubUser}/${ProjectName}:${ImageTag}"