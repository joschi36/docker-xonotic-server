## Summary
Contains Dockerfile and associated artifacts used to build a Docker image to run an Xonotic server in a Docker container. DONT FORGET TO MODIFY SERVER CONFIGURATION (files/server.cfg).

## How To Run
```sh  
$ git clone https://github.com/jerryaldrichiii/docker-xonotic-server.git 
$ cd docker-xonotic-server

# Modify files/server.cfg before proceeding

$ docker build -t [repository/name:tag] . 
$ docker run -d -it --name [container-name] -p [hostport]:26000/udp [repository/name:tag]
```
