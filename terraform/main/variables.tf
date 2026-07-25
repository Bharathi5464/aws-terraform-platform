variable "aws_region" {
  description = "AWS Region where resources will be created" # Purpose of the variable
  type        = string                                       # Variable data type
}

variable "environment" {
  description = "Deployment environment" # Environment (dev, test, prod)
  type        = string                   # Variable data type
}

variable "project_name" {
  description = "Project name" # Name of the project
  type        = string         # Variable data type
}