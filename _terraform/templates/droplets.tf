resource "digitalocean_droplet" "beagle_oefd_net" {
  image = "debian-10-x64"
  name = "beagle.oefd.net"
  region = "tor1"
  size = "s-1vcpu-1gb"
  ipv6 = true
  monitoring = true
  private_networking = true
  ssh_keys = [digitalocean_ssh_key.terry_oefd_ca.id]
  vpc_uuid = digitalocean_vpc.vpc_tor1_1.id
}
