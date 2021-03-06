resource "digitalocean_ssh_key" "terry_oefd_ca" {
  name = "terry@oefd.ca"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZUwIgs8YAhTUgxHz41OY2hn/BgZsQvtsumSz1fCo8X terry@oefd.ca"
}

resource "digitalocean_ssh_key" "terry_oefd_net" {
  name = "terry@oefd.net"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8tYPJ9aXBZet/fDkYRCPoC7FZDBzkX0IIVXoiDZ07d terry@oefd.net"
}
