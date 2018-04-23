resource "aws_security_group" "projectX-sg" {

    vpc_id = "${module.vpc.vpc-id}"
    name = "projectX-sg"
    description = "Security Group - projectX"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32", "${var.gitIPs}"]
    }

    ingress {
        from_port = 5000
        to_port   = 5000
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 7000
        to_port   = 7000
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 8000
        to_port   = 8000
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 8100
        to_port   = 8100
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 8500
        to_port   = 8500
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 9000
        to_port   = 9000
        protocol  = "tcp"
        cidr_blocks = ["${var.vpc_ingressIP}/32"]
    }

    ingress {
        from_port = 2377
        to_port   = 2377
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 7946
        to_port   = 7946
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 7946
        to_port   = 7946
        protocol  = "udp"
        self      = true
    }

    ingress {
        from_port = 4789
        to_port   = 4789
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 4789
        to_port   = 4789
        protocol  = "udp"
        self      = true
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

