resource "digitalocean_vpc" "vpc_tor1_1" {
  name = "vpc-tor1-1"
  region = "tor1"
  ip_range = "172.16.0.0/16"
}
