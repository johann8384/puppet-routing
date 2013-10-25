# == Class: routing::bgpd
#
# Configures bgpd
#
# === Parameters
#
# Document parameters here.
#
# [lan_interface]
# determines what interface to use for making the connection to remote peers
# default is eth0
#
# [lan_description]
# the name to use as a description for that interface
#
# [lan_cidr]
# the cidr notation of the network on that interface, is used as the default advertisment
#
# [tunnels]
# a hash of tunnels and tunnel parameters
# see: routing::gre
#
# === Examples
#
# class { 'routing::bgpd':
#   lan_interface   => 'eth0',
#   lan_description => 'LAN',
#   lan_cidr        => '192.168.0.0/24',
#   tunnels         => { 'peer' => $peer1, 'interface' => 'tun0', 'description' => 'peer1', 'local' => '10.0.0.2', 'remote' => '10.0.0.1', 'remoteasn' => '65531' }
# }
#
# === Authors
#
# Jonathan Creasy <jonathan.creasy@gmail.com>
#
# === Copyright
#
# Copyright 2013 Jonathan Creasy, unless otherwise noted.
#
class routing::bgpd(
  $lan_interface    = 'eth0',
  $lan_description  = 'LAN',
  $lan_cidr         = '192.168.0.0/24',
  $tunnels          = undef,
) inherits routing {
  file { '/etc/quagga/bgpd.conf':
    ensure  => present,
    content => template('routing/bgpd.conf.erb'),
    require => Package['quagga'],
  }

  service { 'bgpd':
    ensure    => running,
    enable    => true,
    require   => File['/etc/quagga/bgpd.conf'],
    subscribe => File['/etc/quagga/bgpd.conf'],
  }
}
