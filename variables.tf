variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID"
}

variable "student_name" {
  type        = string
  default     = "NourAlhuda"
  description = "Student name used for resource naming and tagging"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region for resources"
}