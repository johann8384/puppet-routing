class routing::disable::ospfd {
  service { 'ospfd':
    ensure  => stopped,
    enable  => false,
  }
}
