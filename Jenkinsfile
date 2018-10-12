@Library('pipeline-lib') _

def MAIN_BRANCH                    = 'master'
def DOCKER_REGISTRY_URL            = 'https://registry.hub.docker.com'
def DOCKER_REGISTRY_CREDENTIALS_ID = '6992a9de-fab7-4932-9907-3aba4a70c4c0'
def IMAGE_NAME                     = 'salemove/postgres-temporal-tables'

withResultReporting(slackChannel: '#tm-engage') {
  inDockerAgent() {
    def version
    def dockerImage

    stage('Build docker image') {
      checkout(scm)
      version = sh(returnStdout: true, script: 'git log -n 1 --pretty=format:\'%h\'').trim()
      dockerImage = docker.build(IMAGE_NAME)
    }
    if (BRANCH_NAME == MAIN_BRANCH) {
      stage('Publish docker image') {
        docker.withRegistry(DOCKER_REGISTRY_URL, DOCKER_REGISTRY_CREDENTIALS_ID) {
          echo("Publishing docker image ${dockerImage.imageName()} with tag ${version}")
          dockerImage.push("${version}")
        }
      }
    }
  }
}
