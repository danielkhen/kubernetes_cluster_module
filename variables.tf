variable "name" {
  description = "(Required) The name of the kubernetes cluster."
  type        = string
}

variable "location" {
  description = "(Required) The location of the kubernetes cluster."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The resource group name of the kubernetes cluster."
  type        = string
}

variable "default_node_pool" {
  description = "(Required) The default node pool of the kubernetes cluster."
  type = object({
    name                  = string
    node_count            = number
    vm_size               = string
    vnet_subnet_id        = optional(string)
    enable_auto_scaling   = optional(bool)
    enable_node_public_ip = optional(bool)
    max_pods              = optional(number)
    min_count             = optional(number)
    max_count             = optional(number)
    os_sku                = optional(string)
    os_type               = optional(string)
  })
}

variable "node_pools" {
  description = "(Optional) A list of node pools."
  type = list(object({
    name                  = string
    node_count            = number
    vm_size               = string
    vnet_subnet_id        = optional(string)
    enable_auto_scaling   = optional(bool)
    enable_node_public_ip = optional(bool)
    max_pods              = optional(number)
    min_count             = optional(number)
    max_count             = optional(number)
    os_sku                = optional(string)
    os_type               = optional(string)
  }))
  default = []
}

variable "container_registry_id" {
  description = "(Required) The id of the azure container registry to assign access to the."
  type        = string
}

variable "log_analytics_id" {
  description = "(Required) The id of the log analytics workspace."
  type        = string
}

variable "network_plugin" {
  description = "(Optional) The network plugin of the aks, azure, kubenet or none."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["azure", "kubenet", "none"], var.network_plugin)
    error_message = "Network plugin possible values are azure, kubenet and none."
  }
}

variable "node_resource_group" {
  description = "(Optional) The resource group name where all the components of the kubernetes cluster reside."
  type        = string
  default     = null
}

variable "service_cidr" {
  description = "(Optional) The range of ip addresses assigned to services."
  type        = string
  default     = null
}

variable "dns_service_ip" {
  description = "(Optional) The ip address of the dns service."
  type        = string
  default     = null
}

variable "max_node_provisioning_time" {
  description = "(Optional) The maximum time the autoscaler waits for a node to be provisioned."
  type        = string
  default     = "15m"
}

variable "private_dns_zone_id" {
  description = "(Optional) The id of the private dns zone of the cluster."
  type        = string
  default     = null
}

variable "identity_type" {
  description = "(Optional) The type of the identity of the kubernetes cluster."
  type        = string
  default     = "None"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "None"], var.identity_type)
    error_message = "Identity should be SystemAssigned, UserAssigned or None"
  }
}

variable "role_assignments" {
  description = "(Optional) A list of rules for the system identity, system assigned identity must be enabled."
  type = list(object({
    name  = string
    scope = string
    role  = string
  }))
  default = []
}

variable "user_assigned_identities" {
  description = "(Optional) A list of ids of user assigned identities for the kubernetes cluster, user assigned identity must be enabled."
  type        = list(string)
  default     = null
}