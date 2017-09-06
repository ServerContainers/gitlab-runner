# Docker gitlab-runner (servercontainers/gitlab-runner)
_maintained by ServerContainers_

[FAQ - All you need to know about the servercontainers Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

## What is it

This Dockerfile (available as ___servercontainers/gitlab-runner___) and gives you a gitlab-runner with optional docker support in a container.

For Configuration of the Server you use environment Variables and to register run once manually.

It's based on the [debian:stretch](https://registry.hub.docker.com/_/debian) Image

View in Docker Registry [servercontainers/gitlab-runner](https://registry.hub.docker.com/u/servercontainers/gitlab-runner/)

View in GitHub [ServerContainers/gitlab-runner](https://github.com/ServerContainers/gitlab-runner)

## Configuration

Run this container a privileged container if you don't plan to disable docker.

### Register to GitLab Instance

```
docker run -ti --rm -v $PWD'/config:/etc/gitlab-runner' --privileged servercontainers/gitlab-runner:latest gitlab-runner register -c /etc/gitlab-runner/config.toml
```

just answer all the following questions and you'll end up with a gitlab connection.

### Envs

- DISABLE_DOCKER
    - set this to _true_ to disable the docker daemon inside
    - default it's not set and docker is enabled

### Volumes

- /etc/gitlab-runner
    - place to store the gitlab-runner config
    - needed to hold persistent connection to gitlab
