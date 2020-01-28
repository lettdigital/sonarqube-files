# sonarqube-files
Working sonarqube docker solution with Community Branch Plugin Installed

# Files

## Dockerfile + docker-compose.yml

Dockerized working solution for sonarqube server

### Dockerfile

Compiles a docker image based on `sonarqube` community image with `sonarqube-community-branch-plugin` installed.

### docker-compose.yml

Launches a service called `sonarqube` that used an RDS postgres db instance as backend. To be used with aws.

Before launching the docker service, add the following line to `/etc/sysctl.conf`:

```cfg
vm.max_map_count=262144
```

Reboot the host or execute `sudo sysctl -w vm.max_map_count=262144`.

After that you can safely launch the sonarqube service by running

```
docker-compose up -d
```

The port in which it is launched is 9000. It is good to expose this port through an `nginx` server, either in
a docker container or installed in the host.

## Jenkinsfile

Folders named after technologies like `java` and `python` contain implementation of a jenkins pipeline
that makes use of the sonarqube server you launched previously.

A sonarqube environment must be configured in Jenkins in order to use these pipelines. The environment is called
`ec2-server` and contains the necessary information for jenkins to connect to your sonarqube server instance.

Moreover, you must install the sonarscanner plugin in jenkins and configure the latest sonarscanner tool named
`SonarQube Scanner Latest`.

### python/Jenkinsfile

Two steps are defined in this file:

1. [Code Quality Analysis] If either master branch or a pull request, it runs `sonar-scanner`,
else it ignores the quality gate.

    1.1. Notice that in order for a successful scan to occur, the target repository must contain a valid `sonarproject.properties`
file, with an existing project key configured in the sonarqube server.

2. [Quality Gate] sonarqube plugin`s `waitForQualityGate` is executed with a timeout of one hour.

### python/Jenkinsfile

1. [Build] executes an `mvn` build: `mvn clean package`

2. [Code Quality Analysis][Quality Gate] same as in `python/Jenkinsfile`
