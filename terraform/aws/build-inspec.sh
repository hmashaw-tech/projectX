#

terraform output  | sed s/\ =/:/g > ../../inspec/swarm-config/files/params.yml
