# Jenkins Master Image #

Jenkins Master image pre-configured to be used with ephemeral slaves 

### Prerequisites ###
1. Docksal
2. Docksal-Socal built and running

### Setup ###

1. Create volumes: `fin docker volume create --name jenkins_home` `fin docker volume create --name jenkins_logs`
2. Build Jenkins: `fin docker build -t jenkins_master:latest .`

### Usage ###
Run Jenkins: `fin docker run --name=jenkins_master -d --restart=always -p 8080:8080 -p 50000:50000 --link docksal-socat:socat -v jenkins_home:/var/jenkins_home -v jenkins_logs:/var/log/jenkins jenkins_master`

The following variables can be overriden on build:
JENKINS_USER, JENKINS_PASS, JENKINS_EMAIL - credentials of superuser

JENKINS_URL - URL where Jenkins will be accessible. This is necessary because Jenkins cannot reliably detect such URL from within itself.