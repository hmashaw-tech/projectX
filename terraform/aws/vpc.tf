/**
 * ProjectX
 * By: Mark
 */


# Create VPC
module "vpc" {
    source = "./modules/vpc"

    name = "VPC-ProjectX"
    project-name = "${var.project-name}"
    region = "${var.vpc_region}"
    network-address = "${var.vpc-network-prefix}.0.0/16"
}


# Add Subnets
module "vpc-subnets" {
    source = "./modules/vpc-subnets"

    vpc-id = "${module.vpc.vpc-id}"

    project-name = "${var.project-name}"
    region = "${var.vpc_region}"
    priv1_subnet_addresses = [ "${var.vpc-network-prefix}.0.0/19",   "${var.vpc-network-prefix}.32.0/19",  "${var.vpc-network-prefix}.64.0/19"  ]
    priv2_subnet_addresses = [ "${var.vpc-network-prefix}.192.0/21", "${var.vpc-network-prefix}.200.0/21", "${var.vpc-network-prefix}.208.0/21" ]
    pub_subnet_addresses   = [ "${var.vpc-network-prefix}.128.0/20", "${var.vpc-network-prefix}.144.0/20", "${var.vpc-network-prefix}.160.0/20" ]
}


# Add Internet Gateway
module "vpc-IG" {
    source = "./modules/vpc-IG"

    name = "VPC-ProjectX-IG"

    vpc-id = "${module.vpc.vpc-id}"
    pub-subnet-ids = "${module.vpc-subnets.pub-subnet-ids}"
    
    project-name = "${var.project-name}"
    region = "${var.vpc_region}"
}


# Configure Security Groups
module "vpc-SG" {
    source = "./modules/security-groups"

    region = "${var.vpc_region}"
    vpc-id = "${module.vpc.vpc-id}"

    project-name = "${var.project-name}"

    vpc-ingressIP = "${var.vpc_ingressIP}/32"
    pub_subnet_addresses = [ "${var.vpc-network-prefix}.128.0/20", "${var.vpc-network-prefix}.144.0/20", "${var.vpc-network-prefix}.160.0/20" ]
}
