def fun(String OWASPCheckName) {
    dependencyCheck additionalArguments: "--scan ./ --disableYarnAudit --disableNodeAudit", odcInstallation: "${OWASPCheckName}" \
    dependencyCheckPublisher pattern: "**/dependency-check-report.xml"
}