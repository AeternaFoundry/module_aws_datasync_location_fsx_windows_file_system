variable "datasync_location_fsx_windows_file_systems" {
  description = <<EOT
Map of datasync_location_fsx_windows_file_systems, attributes below
Required:
    - fsx_filesystem_arn
    - password
    - security_group_arns
    - user
Optional:
    - domain
    - region
    - subdirectory
    - tags
    - tags_all
EOT

  type = map(object({
    fsx_filesystem_arn  = string
    password            = string
    security_group_arns = set(string)
    user                = string
    domain              = optional(string)
    region              = optional(string)
    subdirectory        = optional(string)
    tags                = optional(map(string))
    tags_all            = optional(map(string))
  }))
  validation {
    condition = alltrue([
      for k, v in var.datasync_location_fsx_windows_file_systems : (
        v.subdirectory == null || (length(v.subdirectory) >= 1 && length(v.subdirectory) <= 4096)
      )
    ])
    error_message = "must be between 1 and 4096 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.datasync_location_fsx_windows_file_systems : (
        length(v.user) >= 1 && length(v.user) <= 104
      )
    ])
    error_message = "must be between 1 and 104 characters"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

