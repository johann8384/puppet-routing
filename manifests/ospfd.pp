# == Class: routing::ospfd
#
# Configures ospfd
#
# === Parameters
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
# class { 'routing::ospfd':
#   lan_interface   => 'eth0',
#   lan_description => 'LAN',
#   lan_cidr        => '192.168.0.0/24',
#   tunnels         => { 'peer' => $peer1, 'interface' => 'tun0', 'description' => 'peer1', 'local' => '10.0.0.2', 'remote' => '10.0.0.1', 'remoteasn' => '65531' },
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
class routing::ospfd(
  $lan_interface    = 'eth0',
  $lan_description  = 'LAN',
  $lan_cidr         = '192.168.0.0/24',
  $tunnels          = undef,
) inherits routing {
  file { '/etc/quagga/ospfd.conf':
    ensure  => present,
    content => template('routing/ospf.conf.erb'),
    require => Package['quagga'],
  }

  service { 'ospfd':
    ensure    => running,
    enable    => true,
    require   => File['/etc/quagga/ospfd.conf'],
    subscribe => File['/etc/quagga/ospfd.conf'],
  }
}
