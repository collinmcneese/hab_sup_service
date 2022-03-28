#!/bin/bash

# Load variables from last_build.env
source /tmp/habitat/results/last_build.env || . /tmp/habitat/results/last_build.env

export HAB_LICENSE="accept-no-persist"
export HAB_ORIGIN="${pkg_origin}"

log() {
  echo "===> ${1}"
}

# Install Habitat on system
if [ ! -d /hab ]; then
  log "Installing Habitat"
  curl -o /tmp/habinstall.sh https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
  habv2install='bash /tmp/habinstall.sh -t x86_64-linux-kernel2'
  habinstall='bash /tmp/habinstall.sh'
  if [[ $(uname -r) =~ ^2 ]] ; then ${habv2install} ; else ${habinstall} ; fi
fi

# Create `hab` user and group if they do not exist
if getent passwd | grep -q "^hab:" ; then
  log "Hab user exists, skipping user creation"
else
  useradd hab
fi

# Build package
cd /tmp/habitat
hab license accept
hab origin key generate
cp ~/.hab/cache/keys/${pkg_origin}* /hab/cache/keys/
hab pkg build .

# Load variables from last_build.env
source /tmp/habitat/results/last_build.env || . /tmp/habitat/results/last_build.env

log "Installing ${pkg_artifact}"
# Verify that package installs and runs correctly
hab pkg install /tmp/habitat/results/${pkg_artifact}

sleep_seconds=5
i=0
until [ "${i}" -ge 9 ]
do
  hab svc status >/dev/null 2>&1 && break
  log "Habitat supervisor is not yet online, retrying in ${sleep_seconds} seconds"
  i=$((i+1))
  sleep ${sleep_seconds}
done

hab svc status >/dev/null 2>&1 || exit 1
log "Habitat supervisor is online"
