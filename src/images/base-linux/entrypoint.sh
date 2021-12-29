#!/bin/bash

set -eux pipefail

# set localtime
if [ -z ${TZ+x} ]; then
  rm -rf /etc/localtime
  ln -s /usr/share/zoneinfo/${TZ} /etc/localtime
fi

# set group
if [ -z ${GID+x} ]; then
  if [ "$(groups | grep -c ${GID})" -eq 0 ]; then
    groupadd -g ${GID} service
  fi
fi

# set user
if [ -z ${UID+x} ]; then
  if [ "$(cat /etc/passwd | grep -c ${UID})" -eq 0 ]; then
    useradd -m -g ${GID} -u ${UID} service
  fi
fi

# execute app entrypoint
if [ -f "/opt/app/entrypoint.sh" ]; then
  sh /opt/app/entrypoint.sh
fi
