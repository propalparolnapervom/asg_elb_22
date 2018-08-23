
#################################
## Define following variables
## for already configured
## (pre-defined) AWS resources
#################################


################
## AWS ACCESS ##
################

#Necessary AWS account (with appropriate permissions): access_key
variable "access_k" {
  type    = "string"
  default = "AKIAJ54B7ADHQF5FGZ3Q"
}

#Necessary AWS account: secret_key
variable "secret_k" {
  type    = "string"
  default = "TcARuiC8+yV1WOuTdxla4UQAql199NUGIJm9swvT"
}

#Region, where you're going to locate EC2 instances from your ASG
variable "region" {
  type    = "string"
  default = "eu-central-1"
}


#########
## ELB ##
#########

#Name of ELB, will be used with ASG
variable "elbname" {
  type    = "string"
  default = "ELBbyterraform"
}

#Names of AZ  (will be used where needed)
variable "az_1" {
  type    = "string"
  default = "eu-central-1a"
}

variable "az_2" {
  type    = "string"
  default = "eu-central-1b"
}

variable "az_3" {
  type    = "string"
  default = "eu-central-1c"
}

#Name of security_group (will be used where needed)
variable "security_group" {
  type    = "string"
  default = "sg-09cb57eb62caf6685"
}


##########################
## LAUNCH CONFIGURATION ##
##########################

#Name of Launch Configuration
variable "lc_name" {
  type    = "string"
  default = "LC_by_terraform"
}

#AMI that is going to be used for each EC2 instance within ASG
# (Amazon Linux has been chosen for this example as no other was specified)
variable "image_id" {
  type    = "string"
  default = "ami-0233214e13e500f77"
}

#Type of each EC2 withing ASG
variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}


#########
## ASG ##
#########

#Name of the ASG
variable "asg_name" {
  type    = "string"
  default = "ASG_by_terraform"
}

#Minimum amount of instances in the ASG
variable "min_amount" {
  type    = "string"
  default = "2"
}

#Maximum amount of instances in the ASG
variable "max_amount" {
  type    = "string"
  default = "2"
}

#Type of the healthcheck that will be used in the ASG
variable "hlth_ckeck_type" {
  type    = "string"
  default = "ELB"
}
