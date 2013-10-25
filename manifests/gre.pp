# == Class: routing::gre
#
# Configures gre
#
# === Examples
#
#    $lan_interface    = 'em3'
#    $lan_description  = 'LAN'
#    $lan_cidr         = '192.168.4.1/24'
#    $asn              = '65533'
#    $tunnels = {
#      'tun1' => { 'peer' => $peer1, 'interface' => 'tun1', 'description' => 'peer1', 'local' => '10.0.0.6', 'remote' => '10.$
#      'tun2' => { 'peer' => $peer2, 'interface' => 'tun2', 'description' => 'peer2', 'local' => '10.0.0.10', 'remote' => '10$
#    }
#
#    define create_tunnels($peer, $interface, $description, $local, $remote, $remoteasn) {
#      routing::gre { "tunnel_to_${peer}":
#        peer_outer_ip => $peer,
#        peer_inner_ip => $remote,
#        my_inner_ip   => $local,
#        interface     => $interface,
#      }
#    }
#
#    create_resources (create_tunnels, $tunnels)
#
# === Authors
#
# Jonathan Creasy <jonathan.creasy@gmail.com>
#
# === Copyright
#
# Copyright 2013 Jonathan Creasy, unless otherwise noted.
#
define routing::gre(
  $peer_outer_ip,
  $peer_inner_ip,
  $my_inner_ip,
  $interface = 'tun0',
  $enable = true,
) {
  if $enable == true {
    $onboot = 'YES'
  }
  else {
    $onboot = 'NO'
  }

  file { "/etc/sysconfig/network-scripts/ifcfg-${interface}":
    ensure  => present,
    content => template('routing/ifcfg-tunX.erb'),
    notify  => Exec["reload_tunnel_interface_${interface}"],
  }

  exec { "reload_tunnel_interface_${interface}":
    command     => "/sbin/ifdown ${interface}; /sbin/ifup ${interface}",
    refreshonly => true,
  }
}
