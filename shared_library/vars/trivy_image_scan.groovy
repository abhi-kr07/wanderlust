def fun(String ProjectName) {
    sh "trivy image ${ProjectName}"
}