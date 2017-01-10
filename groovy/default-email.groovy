import jenkins.model.*

def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()

jenkinsLocationConfiguration.setAdminAddress("admin@localhost")
jenkinsLocationConfiguration.setUrl("http://jenkinsurl/") 
jenkinsLocationConfiguration.save()
