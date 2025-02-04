def call(String ProjectName, String ImageTag, String DockerhubUser){
  sh "docker rmi ${DockerhubUser}/${ProjectName}:${ImageTag}"
}