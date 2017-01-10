FROM jenkins:2.7.4-alpine
MAINTAINER haixiang

USER root

RUN mkdir /var/log/jenkins && \
    chown -R jenkins:jenkins /var/log/jenkins

USER jenkins

# Install initial plugins
COPY plugins.txt /tmp/

# Add initial YADP configuration
COPY configs/config.xml ${JENKINS_HOME}/

# add default user
ENV JENKINS_USER=admin
ENV JENKINS_PASS=admin
COPY groovy/default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

# add default email and Jenkins URL.
# This is necessary because Jenkins cannot reliably detect such a URL from within itself.
ENV JENKINS_EMAIL=admin@localhost
# default URL for local docksal machine
ENV JENKINS_URL=http://192.168.64.100:8080/
COPY groovy/default-email.groovy /usr/share/jenkins/ref/init.groovy.d/
RUN sed -i -e "s,admin@localhost,$JENKINS_EMAIL,g; s,http://jenkinsurl/,$JENKINS_URL,g" /usr/share/jenkins/ref/init.groovy.d/default-email.groovy

# Workaround until it is possible to use .txt file as with plugins.sh
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
