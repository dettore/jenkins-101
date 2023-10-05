#FROM jenkins/jenkins:2.332.3-jdk11
#FROM jenkins/jenkins:lts
FROM jenkins/jenkins:2.414.2-jdk11

# Switch to the root user to install packages
USER root

# Install Python 3 and other required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    lsb-release

# Install Docker CLI (if needed)
RUN apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to the Jenkins user
USER jenkins

# Install Jenkins plugins (you can keep the plugin versions from your original Dockerfile)
RUN jenkins-plugin-cli --plugins "blueocean:1.25.7 docker-workflow:1.28"