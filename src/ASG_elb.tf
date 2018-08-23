

####################################################################
##
## ASG will be created together with ELB in a simplest configuration
## for port 22 handling.
##
## Assuming that following data/resources
## were already pre-defined by now:
##   - AWS account with appropriate permissions is created;
##   - Necessary VPC is created;
##   - Necessary Role (IAM) is created;
##   - Necessary Security_Group (EC2) is created;
##   - Necessary Key_pair is created
##
##  Author: S.Burtovyi, Aug 2018
####################################################################




###########################
## Provide access to AWS ##
###########################

provider "aws" {
  access_key = "${var.access_k}"
  secret_key = "${var.secret_k}"
  region     = "${var.region}"
}


#####################
## Defining of ELB ##
#####################

#Define ELB that will balancing traffic on port 22
# (ELB - Classic Load Balancer - has been chosen as no other was specified)
resource "aws_elb" "ELBbyterraform" {
  name               = "${var.elbname}"
  availability_zones = ["${var.az_1}", "${var.az_2}", "${var.az_3}"]

  listener {
    instance_port      = 22
    instance_protocol  = "TCP"
    lb_port            = 2222
    lb_protocol        = "TCP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 30
  }

  security_groups = ["${var.security_group}"]

}



######################################
## Defining of Launch Configuration ##
######################################

#Define configuration that will be used for each EC2 instance in the ASG
resource "aws_launch_configuration" "LC_by_terraform" {
  name                   = "${var.lc_name}"
  image_id               = "${var.image_id}"
  instance_type          = "${var.instance_type}"
  security_groups        = ["${var.security_group}"]

}


#####################
## Defining of ASG ##
#####################

#Define ASG that eventually has to be created
resource "aws_autoscaling_group" "ASG_by_terraform" {
  launch_configuration = "${aws_launch_configuration.LC_by_terraform.name}"
  availability_zones = ["${var.az_1}", "${var.az_2}", "${var.az_3}"]
  min_size = "${var.min_amount}"
  max_size = "${var.max_amount}"
  load_balancers = ["${aws_elb.ELBbyterraform.name}"]
  health_check_type = "${var.hlth_ckeck_type}"
}
