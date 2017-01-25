FROM jenkins:2.7.4-alpine
MAINTAINER haixiang

# Get plugins list and install.
COPY plugins.txt /tmp/
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')

# Customizable settings:
# Default user.
ENV JENKINS_USER=admin \
    JENKINS_PASS=admin \
    # Default email.
    JENKINS_EMAIL=admin@localhost \
    # Default URL.
    # This is necessary because Jenkins cannot reliably detect such a URL from within itself.
    JENKINS_URL=http://192.168.64.100:8080/

# Create log directory.
USER root
RUN mkdir -p /var/log/jenkins && \
    chown -R jenkins:jenkins /var/log/jenkins

USER jenkins

# Add initial YADP configuration.
COPY configs/config.xml ${JENKINS_HOME}/

# Custom JENKINS groovy scripts...
COPY groovy/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# Skip initial setup.
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
