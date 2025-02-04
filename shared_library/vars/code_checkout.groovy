def call(String GitBranch , String GitURL) {
    git branch: "${GitBranch}" , url: "${GitURL}"
}