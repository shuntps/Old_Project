FROM jenkins/jenkins
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
        ca-certificates curl gnupg2 nano sudo \
        software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
USER jenkins