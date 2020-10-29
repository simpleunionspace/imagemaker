# INFO
ARG IMAGE_BASE_NAME
ARG IMAGE_BASE_VERSION
FROM $IMAGE_BASE_NAME:$IMAGE_BASE_VERSION
LABEL name="base linux image ($IMAGE_BASE_NAME:$IMAGE_BASE_VERSION)" \
      vendor="Simple Union"

# BUILD
## prepare
RUN rm -rf /media \
    && rm -rf /mnt \
    && rm -rf /srv \
    && rm -rf /tmp/* \
    && rm -rf /home \
    && rm -rf /anaconda-post.log \
    && rm -rf /etc/X11 \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*
## system content
COPY system/ /
## setup
ARG SYSTEM_PACKAGES_MANAGER
RUN rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/GMT /etc/localtime \
    && $SYSTEM_PACKAGES_MANAGER -y update \
    && $SYSTEM_PACKAGES_MANAGER -y upgrade \
    && $SYSTEM_PACKAGES_MANAGER -y install less \
                                           tree \
                                           nano \
                                           wget \
                                           gettext \
                                           telnet \
                                           tcpdump \
                                           strace \
                                           htop \
                                           unzip \
    && $SYSTEM_PACKAGES_MANAGER -y autoremove \
    && $SYSTEM_PACKAGES_MANAGER -y autoremove \
    && $SYSTEM_PACKAGES_MANAGER -y autoremove \
    && $SYSTEM_PACKAGES_MANAGER -y clean all \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*
## configs content
COPY configs/ /

# CONFIGURATION
## volumes
VOLUME /opt/app/data
VOLUME /opt/app/conf
VOLUME /opt/app/logs
VOLUME /opt/app/cache
## ports
### none
## environment
### none

# ENTRYPOINT
ENTRYPOINT ["bash"]
