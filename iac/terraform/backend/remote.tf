terraform {
  backend "consul" {
    address = "demo.consul.io"
    path    = "getting-started-wayne"
    lock    = false
    scheme  = "https"
  }
}