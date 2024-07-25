@Library(['piper-lib', 'piper-lib-os']) _

pipeline {
    agent any
    environment{
        CF_CRED = credentials('CF-TECHUSER')
    }
    stages {
        stage('Abc') {
            steps {

                dockerExecute(script: this, dockerImage: 'karma-ui5.int.repositories.cloud.sap/karma-ui5:latest', dockerWorkspace: '/') {
                  sh "cd srv && mvn clean install"
                }
            }
        }
        stage('Install') {
            steps {

                dockerExecute(script: this, dockerImage: 'karma-ui5.int.repositories.cloud.sap/karma-ui5:latest', dockerWorkspace: '/') {
                  sh "cds build --production"
                  sh "npm config ls"
                  sh "mbt build -t gen --mtar mta.tar"
                }
            }
        }
      stage('Deploy'){
                        steps {
                                  echo("Deploying MTAR to org RMCFKVPR and myspace Space...")
                                    script{
                                            dockerExecute(dockerImage:'karma-ui5.int.repositories.cloud.sap/karma-ui5:latest',
                                            script: this){
                                                      sh "cf login -u $CF_CRED_USR -p $CF_CRED_PSW -a api.cf.sap.hana.ondemand.com -o RMTEST_RMCFKVPR -s myspace"
                                                      sh "cf deploy gen/mta.tar -f"
                                            }
                                          }
                                }
                    }
    }
}