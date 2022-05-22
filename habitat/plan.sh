pkg_name=hab_sup_service
pkg_origin=collinmcneese
pkg_version="1.6.477"
pkg_maintainer="Collin McNeese <collin@mydevsandbox.com>"
pkg_license=("Apache-2.0")
pkg_deps=(core/hab-sup)
pkg_build_deps=()
pkg_description="Creates service for Chef Habitat supervisor"
pkg_svc_user=root
# dummy run hook to set install user properly -- https://github.com/habitat-sh/habitat/issues/6341
pkg_svc_run="return 0"


do_build() {
  return 0
}

do_install() {
  return 0
}
