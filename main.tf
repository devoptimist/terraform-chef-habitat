locals {
  effortless_hab_config = {
    "chef_habitat_wrapper" = {
      "force"            = var.force_run,
      "accept_license"   = var.accept_license,
      "install_url"      = var.hab_linux_install_url,
      "create_user"      = var.create_hab_user,
      "bldr_url"         = var.bldr_url,
      "remote_sup"       = var.remote_sup,
      "remote_sup_http"  = var.remote_sup_http,
      "install_action"   = var.hab_install_action,
      "permanent_peer"   = var.hab_sup_permanent_peer,
      "listen_ctl"       = var.hab_sup_listen_ctl,
      "listen_gossip"    = var.hab_sup_listen_gossip,
      "listen_http"      = var.hab_sup_listen_http,
      "org"              = var.hab_sup_org,
      "peer"             = var.hab_sup_peers,
      "ring"             = var.hab_sup_ring,
      "sup_channel"      = var.hab_sup_channel,
      "auto_update"      = var.hab_sup_auto_update,
      "sup_auth_token"   = var.hab_sup_auth_token,
      "sup_action"       = var.hab_sup_action,
      "packages"         = var.hab_packages,
      "pkg_channel"      = var.hab_pkg_channel,
      "pkg_binlink"      = var.hab_pkg_binlink,
      "pkg_action"       = var.hab_pkg_action,
      "user_toml_action" = var.hab_user_toml_action,
      "services"         = var.hab_services,
      "service_channel"  = var.hab_service_channel,
      "binding_mode"     = var.hab_service_binding_mode,
      "service_action"   = var.hab_service_action,
      "config_action"    = var.hab_config_action
    }
  }
}

module "effortless_bootstrap_hab" {
  source            = "srb3/effortless-bootstrap/chef"
  version           = "0.13.0"
  ip                = var.ip
  user_name         = var.user_name
  user_pass         = var.user_pass
  user_private_key  = var.user_private_key
  config            = local.effortless_hab_config
  module_depends_on = var.module_depends_on
  system_type       = var.system_type
  hab_version       = var.hab_version
  jq_windows_url    = var.jq_windows_url
  jq_linux_url      = var.jq_linux_url
  effortless_pkg    = var.effortless_hab_pkg
  clear_node_data   = var.clear_node_data
  ssl_cert_file     = var.ssl_cert_file
}
