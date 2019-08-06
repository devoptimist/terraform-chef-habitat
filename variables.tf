############ connection details #################

variable "ips" {
  description = "A list of ip addresses where we will install hab and run services"
  type        = list
}

variable "instance_count" {
  description = "The number of instances that will have chef-solo run on them"
  type        = number
}

variable "user_name" {
  description = "The ssh or winrm user name used to access the ip addresses provided"
  type        = string
  default     = ""
}

variable "user_names" {
  description = "A list of ssh or winrm user names used to access the ip addresses provided"
  type        = list(string)
  default     = []
}

variable "user_pass" {
  description = "The ssh or winrm user password used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "user_passes" {
  description = "A list of ssh or winrm user passwords used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = list(string)
  default     = []
}

variable "user_private_key" {
  description = "The user key used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "user_private_keys" {
  description = "A list of user keys used to access the ip addresses (either user_pass/s or user_private_key/s needs to be set)"
  type        = list(string)
  default     = []
}

################# misc ############################

variable "system_type" {
  description = "The system type linux or windows"
  type        = string
  default     = "linux"
}

variable "jq_windows_url" {
  description = "A url to a jq binary to download, used in the install process"
  type        = string
  default     = "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe"
}

variable "jq_linux_url" {
  description = "A url to a jq binary to download, used in the install process"
  type        = string
  default     = "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
}

variable "hab_version" {
  description = "The version of habitat to install, this should match the version of habitat installed by the effortless hab package"
  type        = string
  default     = "0.83.0"
}

variable "hab_linux_install_url" {
  description = "A url to a hab binary to download"
  type        = string
  default     = "https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh"
}

variable "hab_windows_install_url" {
  description = "A url to a hab binary to download"
  type        = string
  default     = "https://api.bintray.com"
}

############ habitat variables ##################

###### global hab settings

variable "force_run" {
  description = "Set to anything other than default to force a rerun of provisioning on all servers"
  type    = string
  default = "default"
}

variable "accept_license" {
  description = "Shall we accept the chef product license"
  type        = bool
  default     = true
}

variable "create_hab_user" {
  description = "If true the hab user/group is created"
  type        = bool
  default     = true
}

variable "bldr_url" {
  description = "The URL of the habitat builder"
  type        = string
  default     = "https://bldr.habitat.sh"
}

variable "remote_sup" {
  description = "Address to a remote Supervisor's Control Gateway"
  type        = string
  default     = "127.0.0.1:9632"
}

variable "remote_sup_http" {
  description = "Address for remote supervisor http port. Used to pull existing configuration data. If this is invalid, config will be applied on every Chef run"
  type        = string
  default     = "127.0.0.1:9631"
}

variable "hab_install_action" {
  description = "The action to take when installing habitat on a system; install/upgrade"
  type        = string
  default     = "install"
}

variable "hab_sup_permanent_peer" {
  description = "Should this supervisor be a permanent peer"
  type        = bool
  default     = false
}

variable "hab_sup_listen_ctl" {
  description = "The address and port for the supervisors ctl gateway"
  type        = string
  default     = null
}

variable "hab_sup_listen_gossip" {
  description = "The address and port for the supervisors gossip protocal"
  type        = string
  default     = null
}

variable "hab_sup_listen_http" {
  description = "The address and port for the supervisors http endpoint (census)"
  type        = string
  default     = null
}

variable "hab_sup_org" {
  description = "The name of the superviosr organisation"
  type        = string
  default     = "default"
}

variable "hab_sup_peers" {
  description = "A list of peers for the supervisor to connect to"
  type        = list
  default     = []
}

variable "hab_sup_ring" {
  description = "Start the Supervisor with the --ring param, specifying the name of the ring key to use"
  type        = string
  default     = null
}

variable "hab_sup_channel" {
  description = "The channel to install Habitat from. Defaults to stable"
  type        = string
  default     = "stable"
}

variable "hab_sup_auto_update" {
  description = "Should the hab supervisor auto update"
  type        = bool
  default     = false
}

variable "hab_sup_auth_token" {
  description = "An auth token for talking to a provate org in bldr"
  type        = string
  default     = null
}

variable "hab_sup_action" {
  description = "The default action for the habitat supervisor; options run or stop"
  type        = string
  default     = "run"
}

variable "hab_packages" {
  description = "A map of habitat package names (plus options) to install on the system"
  type        = map
  default     = {} 
}

variable "hab_pkg_channel" {
  description = "The channel to install the packages in hab_packages from, can be overriden in the packages option map"
  type        = string
  default     = "stable"
}

variable "hab_pkg_binlink" {
  description = "Should the packages being installed also be binlinked, can be overriden in the packages option map"
  type        = bool
  default     = false
}

variable "hab_pkg_action" {
  description = "Default action to take on each package; install or remove"
  type        = string
  default     = "install"
}

variable "hab_user_toml_action" {
  description = "Default action to take on user toml data; create or delete"
  type        = string
  default     = "create"
}

variable "hab_services" {
  description = "A map of habitat service names and their config options"
  type        = map
  default     = {}
}

variable "hab_service_channel" {
  description = "The channel to load the services in the hab_services map from, can be overriden in the indiviual services config map"
  type        = string 
  default     = "stable"
}

variable "hab_service_binding_mode" {
  description = "The binding mode to use when a service from the hab_services map is loaded, can be overriden in the indiviual services config map"
  type        = string
  default     = "strict"
}

variable "hab_service_action" {
  description = "The default action to apply to the services in the hab_service map, can be overriden in the individual service config map"
  type        = string
  default     = "load"
}

variable "hab_config_action" {
  description = "The default action to apply to the service configuration specified in the hab_service map, can be overriden in the individual service config_action in the hab_service map"
  type        = string
  default     = "apply"
}

variable "effortless_hab_pkg" {
  description = "The effortless package used to bootstrap the full habitat setup"
  type        = string
  default     = "devoptimist/chef_habitat_wrapper"
}

variable "clear_node_data" {
  description = "Should we remove the node state at the end of the effortless run"
  type        = bool
  default     = true
}
