FROM sonarqube

USER root
RUN apt-get update && apt-get install -y wget

RUN cd /opt/sonarqube/lib/common \
    && wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.2.0/sonarqube-community-branch-plugin-1.2.0.jar

USER sonarqube
