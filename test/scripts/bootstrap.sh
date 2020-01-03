#!/bin/bash

# Load variables from last_build.env
source /tmp/habitat/results/last_build.env || . /tmp/habitat/results/last_build.env

export HAB_LICENSE="accept-no-persist"
export HAB_ORIGIN="${pkg_origin}"

# Install Habitat on system
if [ ! -d /hab ]; then
  echo "Installing Habitat"
  curl -o /tmp/habinstall.sh https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
  habv2install='bash /tmp/habinstall.sh -t x86_64-linux-kernel2'
  habinstall='bash /tmp/habinstall.sh'
  if [[ $(uname -r) =~ ^2 ]] ; then ${habv2install} ; else ${habinstall} ; fi
fi

# Create `hab` user and group if they do not exist
if getent passwd | grep -q "^hab:" ; then
  echo "Hab user exists, skipping user creation"
else
  useradd hab
fi

# Build package
cd /tmp/habitat
hab license accept
hab origin key generate
hab pkg build .

# Load variables from last_build.env
source /tmp/habitat/results/last_build.env || . /tmp/habitat/results/last_build.env

# Install package
echo "Installing ${pkg_artifact}"
hab pkg install /tmp/habitat/results/${pkg_artifact}
# bootstrapfile='/tmp/habitat/results/bootstrap.json'

# echo "{\"bootstrap_mode\": \"true\"}" > ${bootstrapfile}

# echo "Determine pkg_prefix for ${pkg_artifact}"
# pkg_prefix=$(find "/hab/pkgs/${pkg_origin}/${pkg_name}" -maxdepth 2 -mindepth 2 | sort | tail -n 1)
# echo "Found: ${pkg_prefix}"

# echo "Running chef for ${pkg_name}"
# cd "${pkg_prefix}" || exit 1
# hab pkg exec "${pkg_origin}/${pkg_name}" chef-client -z -c "${pkg_prefix}/config/bootstrap-config.rb"

# Cleanup
