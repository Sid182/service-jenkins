FROM jenkins:2.7.4-alpine

# Jenkins logs directory.
ENV JENKINS_LOGS=/var/log/jenkins
# Skip initial setup.
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false" \
    # Set number of threads and log file for Jenkins.
    JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --logfile=${JENKINS_LOGS}/jenkins.log" \
    # Customizable settings:
    # Default admin user.
    JENKINS_USER=admin \
    JENKINS_PASS=admin \
    # Default email.
    JENKINS_EMAIL=admin@localhost \
    # Default URL.
    # This is necessary because Jenkins cannot reliably detect such a URL from within itself.
    JENKINS_URL=http://192.168.64.100:8080/

# Get plugins list.
COPY plugins.txt /tmp/
# Add initial YADP configuration.
COPY configs/config.xml ${JENKINS_HOME}/
# Custom JENKINS groovy scripts...
COPY groovy/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# Create log directory.
USER root
RUN mkdir -p ${JENKINS_LOGS} && \
    chown -R jenkins:jenkins ${JENKINS_LOGS}
USER jenkins
# Install plugins from txt file.
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')
