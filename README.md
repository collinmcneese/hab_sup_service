# hab_sup_service

Creates service for Chef Habitat supervisor.

## Supports

* Linux (init.d or systemd), kernel 2+.

## Usage

Package can be installed via `hab pkg install` command and contains install run hook which will create service configurations, start the service and enable for automatic start on boot.

This package contains a `pkg_svc_run` command only so that installtion will execute as correct package user, `root`.  This package should not be loaded as a service as it performs no regular functions after installation.

Upon installation, will check for the presence of `/hab/sup/default/config/sup.toml` and create if missing.
TODO: Add support for supervisor options such as secret, ring, etc.
