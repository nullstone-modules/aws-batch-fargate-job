data "ns_connection" "network" {
  name     = "network"
  contract = "network/aws/vpc"
}

locals {
  vpc_id             = data.ns_connection.network.outputs.vpc_id
  private_cidrs      = data.ns_connection.network.outputs.private_cidrs
  public_cidrs       = data.ns_connection.network.outputs.public_cidrs
  private_subnet_ids = data.ns_connection.network.outputs.private_subnet_ids
}
