resource "aws_vpc" "environement-example-two" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "terraform-aws-vpc-exapmple-two"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block = "${cidrsubnet(aws_vpc.environement-example-two.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.environement-example-two.id}"
  availability_zone = "eu-west-2a"
}

resource "azurerm_resource_group" "azy_network" {
  location = "East US"
  name= "devResourceGrp"
}

resource "azurerm_virtual_network" "blue_virtual_network" {
  address_space =["10.0.0.0/16"]
  location = "East US"
  name = "bluevirtnetwork"
  resource_group_name = "${azurerm_resource_group.azy_network.name}"
  dns_servers = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}
