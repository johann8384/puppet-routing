class routing::disable::bgpd {
  service { 'bgpd':
    ensure  => stopped,
    enable  => false,
  }
}
