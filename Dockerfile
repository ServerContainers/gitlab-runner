FROM debian:stretch

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -q -y update \
 && apt-get -q -y install curl \
 && curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | bash \
 && curl -L https://get.docker.com/ | bash \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
 && chmod a+x /usr/local/bin/docker-compose

COPY docker/pin-gitlab-runner.pref /etc/apt/preferences.d/pin-gitlab-runner.pref

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -q -y update \
 && apt-get -q -y install --allow-unauthenticated gitlab-ci-multi-runner \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 \
 && usermod -aG docker gitlab-runner

COPY docker/entrypoint /entrypoint

ENTRYPOINT ["/entrypoint"]

VOLUME ["/etc/gitlab-runner"]

CMD ["gitlab-runner", "run", "-c", "/etc/gitlab-runner/config.toml"]
