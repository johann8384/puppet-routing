class routing::zebra(
  $lan_interface    = 'eth0',
  $lan_description  = 'LAN',
  $lan_cidr         = '192.168.0.0/24',
  $tunnels,
) inherits routing::quagga {
  file { '/etc/quagga/zebra.conf':
    ensure  => present,
    content => template('routing/zebra.conf.erb'),
    require => Package['quagga'],
  }

  service { 'zebra':
    ensure  => running,
    enable  => true,
    require => File['/etc/quagga/zebra.conf'],
    subscribe => File['/etc/quagga/zebra.conf'],
  }
}
