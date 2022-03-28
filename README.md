# hab_sup_service

Creates a system service for Chef Habitat supervisor.

## Supports

- Linux (init.d or systemd), kernel 2+.

## Usage

- Package can be installed via `hab pkg install` command and contains install run hook which will create service configurations, start the service and enable for automatic start on boot.
- This package contains a `pkg_svc_run` command only so that installtion will execute as correct package user, `root`.  This package should not be loaded as a service as it performs no regular functions after installation.
- Upon installation, will check for the presence of `/hab/sup/default/config/sup.toml` and create if missing.
- Package version is based on the most recent version of Habitat this package was built from that works.  Ex: `pkg_version="1.6.477"` indicates that this package has been tested with `core/hab/1.6.477`
- TODO: Add support for supervisor options such as secret, ring, etc.
