FROM sonarqube:7.9-community

USER root
RUN apt-get update && apt-get install -y wget

RUN cd /opt/sonarqube/ \
    && wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.2.0/sonarqube-community-branch-plugin-1.2.0.jar \
    && cp sonarqube-community-branch-plugin-1.2.0.jar lib/common \
    && cp sonarqube-community-branch-plugin-1.2.0.jar extensions/plugins \
    && rm sonarqube-community-branch-plugin-1.2.0.jar

USER sonarqube
