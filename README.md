# Overview
This module will install habitat, setup a supervisor, install habitat packages, load and configure habitat services to one or more servers.
Under the hood this module uses a Chef `Effortless Infra` package to install and setup everything. Once the native habitat provisioner for terraform supports Windows, I will switich this module to use that instead. This module supports managing habitat and its services on both Windows and Linux

#### Supported platform families:
 * Debian
 * SLES
 * RHEL
 * Windows

## Usage

```hcl

module "chef_habitat_install" {
  source               = "devoptimist/habitat/chef"
  version              = "0.0.17"
  ips                  = ["172.16.0.23"]
  instance_count       = 1
  ssh_user_name        = "ec2-user"
  ssh_user_private_key = "~/.ssh/id_rsa"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|ip|An ip address where chef habitat will be installed and services loaded|list|[]|no|
|user_name|The ssh user name used to access the ip addresses provided|string||yes|
|user_pass|The ssh user password used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|user_private_key|The ssh user key used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|accept_license|Shall we accept the chef product license|bool|true|no|
|install_url|The URL to that holds the habitat install script|string|https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh|no|
|create_hab_user|If true the hab user/group is created|bool|true|no|
|bldr_url|The URL of the habitat builder|string|https://bldr.habitat.sh|no|
|remote_sup|Address to a remote Supervisor's Control Gateway|string|127.0.0.1:9632|no|
|remote_sup_http|Address for remote supervisor http port. Used to pull existing configuration data. If this is invalid, config will be applied on every Chef run|string|127.0.0.1:9631|no|
|hab_install_action|The action to take when installing habitat on a system; install/upgrade|string|install|no|
|hab_sup_permanent_peer|Should this supervisor be a permanent peer|bool|false|no|
|hab_sup_listen_ctl|The address and port for the supervisors ctl gateway|string|null|no|
|hab_sup_listen_gossip|The address and port for the supervisors gossip protocal|string|null|no|
|hab_sup_listen_http|The address and port for the supervisors http endpoint (census)|string|null|no|
|hab_sup_org|The name of the superviosr organisation|string|default|no|
|hab_sup_peer|A list of peers for the supervisor to connect to|list|null|no|
|hab_sup_ring|Start the Supervisor with the --ring param, specifying the name of the ring key to use|string|null|no|
|hab_sup_channel|The channel to install Habitat from. Defaults to stable|string|stable|no|
|hab_sup_auto_update|Should the hab supervisor auto update|bool|false|no|
|hab_sup_auth_token|An auth token for talking to a provate org in bldr|string|null|no|
|hab_sup_action|The default action for the habitat supervisor; options run or stop|string|run|no|
|hab_packages|A map of habitat package names (plus options) to install on the system|map|{}|no|
|hab_pkg_channel|The channel to install the packages in hab_packages from, can be overriden in the packages option map|string|stable|no|
|hab_pkg_binlink|Should the packages being installed also be binlinked, can be overriden in the packages option map|bool|false|no|
|hab_pkg_action|Default action to take on each package; install or remove|string|install|no|
|hab_user_toml_action|Default action to take on user toml data; create or delete|string|create|no|
|hab_services|A map of habitat service names and their config options|map|{}|no|
|hab_service_channel|The channel to load the services in the hab_services map from, can be overriden in the indiviual services config map|string|stable|no|
|hab_service_binding_mode|The binding mode to use when a service from the hab_services map is loaded, can be overriden in the indiviual services config map|string|strict|no|
|hab_service_action|The default action to apply to the services in the hab_service map, can be overriden in the individual service config map|string|load|no|
|hab_config_action|The default action to apply to the service configuration specified in the hab_service map, can be overriden in the individual service config_action in the hab_service map|string|apply|no|

## Map Variable examples

### hab_packages

```hcl
hab_packages = {
  "core/vim" = {
    "version" = "8.1.0577/20181219210623"
  },
  core/zsh = {}
}
```

### hab_services

```hcl
hab_services = {
  "devoptimist/haproxy" = {
    "strategy" = "rolling",
    "topology" = "standalone",
    "channel" = "stable",
    "group" = "production",
    "binding_mode" = "relaxed",
    "config" = {
      "backend" = {
        "members" = [
          {"ip" = "127.0.0.1", "port" = "8080"}
        ]
      }
    }
  }
}
```

```hcl
hab_services = {
  "core/elasticsearch" = {
    "user_toml_config" = {
      "runtime" = {
        "heapsize" = "2g"
      }
    }
  }
}
```
