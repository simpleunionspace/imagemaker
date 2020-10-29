# INFO
FROM centos:8
LABEL name="base linux image" \
      vendor="Simple Union"

# BUILD
# prepare
RUN rm -rf /media \
    && rm -rf /mnt \
    && rm -rf /srv \
    && rm -rf /tmp/* \
    && rm -rf /home \
    && rm -rf /anaconda-post.log \
    && rm -rf /etc/X11 \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*
# system content
COPY system/ /
# setup
RUN rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/GMT /etc/localtime \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && dnf -y update \
    && dnf -y install less \
                      tree \
                      nano \
                      wget \
                      gettext \
                      telnet \
                      tcpdump \
                      strace \
                      htop \
                      unzip \
    && dnf -y autoremove \
    && dnf -y autoremove \
    && dnf -y autoremove \
    && dnf -y clean all \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*
# configs content
COPY configs/ /

# CONFIGURATION
# volumes
# none
# ports
# none
# environment
# none

# ENTRYPOINT
ENTRYPOINT ["bash"]
