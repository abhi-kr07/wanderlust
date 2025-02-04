def fun(String SonarServerName , String ProjectName , String ProjectKey ) {
    withSonarQubeEnv("${SonarServerName}") {
        sh ''' ${SCANNER_HOME}/bin/sonar_scanner -Dsonar.projectName=${ProjectName} \
        -Dsonar.projectKey=${ProjectKey} -X'''
    }
}