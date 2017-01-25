# Jenkins Master Image #

Jenkins Master image pre-configured to be used with ephemeral slaves 

### Prerequisites ###
1. Docksal
2. Docksal-Socat built and running ([docksal/service-socat](https://github.com/docksal/service-socat))

### Setup ###

1. Create volumes: 
    - `fin docker volume create --name jenkins_home`
    - `fin docker volume create --name jenkins_logs`
2. Build Jenkins: 
    - `fin docker build -t jenkins_master:latest .`

### Usage ###

Run Jenkins:
 
`fin docker run --name=jenkins_master -d --restart=always -p 8080:8080 -p 50000:50000 --link docksal-socat:socat -v jenkins_home:/var/jenkins_home -v jenkins_logs:/var/log/jenkins jenkins_master`

Configurable variables:
 - JENKINS_USER (Default: `admin`) - superuser username
 - JENKINS_PASS (Default: `admin`) - superuser pass
 - JENKINS_EMAIL (Default: `admin@localhost`) - E-mail address
 - JENKINS_URL (Default: `http://192.168.64.100:8080/`) - URL where Jenkins will be accessible. This is necessary because Jenkins cannot reliably detect such URL from within itself.

User `-e` argument to override default values, e.g. to change admin account and pass add `-e JENKINS_USER=John -e JENNS_PASS=123`:

`fin docker run --name=jenkins_master -d --restart=always -p 8080:8080 -p 50000:50000 --link docksal-socat:socat -v jenkins_home:/var/jenkins_home -v jenkins_logs:/var/log/jenkins -e JENKINS_USER=John -e JENNS_PASS=123 jenkins_master`
