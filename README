routing

This is the routing module.

License
-------


Contact
-------


Support
-------

Please log tickets and issues at our [Projects site](http://projects.example.com)

Examples
--------

```ruby
$peer1 = '65.175.90.34'
$peer2 = '199.119.124.102'
$peer3 = '199.119.123.200'

case $fqdn {
  'peer1': {
    $lan_interface    = 'virbr0'
    $lan_description  = 'LAN'
    $lan_cidr         = '192.168.122.0/24'
    $asn              = '65531'
    $tunnels = {
      'tun0' => { 'peer' => $peer2, 'interface' => 'tun0', 'description' => 'peer2', 'local' => '10.0.0.1', 'remote' => '10.0.0.2', 'remoteasn' => '65532' },
      'tun1' => { 'peer' => $peer3, 'interface' => 'tun1', 'description' => 'peer3', 'local' => '10.0.0.5', 'remote' => '10.0.0.6', 'remoteasn' => '65533' }
    }
  }
  'peer2': {
    $lan_interface    = 'bond1.4001'
    $lan_description  = 'LAN'
    $lan_cidr         = '10.50.66.0/24'
    $asn              = '65532'
    $tunnels = {
      'tun0' => { 'peer' => $peer1, 'interface' => 'tun0', 'description' => 'peer1', 'local' => '10.0.0.2', 'remote' => '10.0.0.1', 'remoteasn' => '65531' },
      'tun2' => { 'peer' => $peer3, 'interface' => 'tun2', 'description' => 'peer3', 'local' => '10.0.0.9', 'remote' => '10.0.0.10', 'remoteasn' => '65533' }
    }
  }
  'peer3': {
    $lan_interface    = 'em3'
    $lan_description  = 'LAN'
    $lan_cidr         = '192.168.4.1/24'
    $asn              = '65533'
    $tunnels = {
      'tun1' => { 'peer' => $peer1, 'interface' => 'tun1', 'description' => 'peer1', 'local' => '10.0.0.6', 'remote' => '10.0.0.5', 'remoteasn' => '65531' },
      'tun2' => { 'peer' => $peer2, 'interface' => 'tun2', 'description' => 'peer2', 'local' => '10.0.0.10', 'remote' => '10.0.0.9', 'remoteasn' => '65532' }
    }
  }
}

define create_tunnels($peer, $interface, $description, $local, $remote, $remoteasn) {
  routing::gre { "tunnel_to_${peer}":
    peer_outer_ip => $peer,
    peer_inner_ip => $remote,
    my_inner_ip   => $local,
    interface     => $interface,
  }
}

create_resources (create_tunnels, $tunnels)

class { 'routing::zebra':
  lan_interface   => $lan_interface,
  lan_description => $lan_description,
  lan_cidr        => $lan_cidr,
  tunnels         => $tunnels,
}

class { 'routing::disable::bgpd': }
class { 'routing::ospfd':
  lan_interface   => $lan_interface,
  lan_description => $lan_description,
  lan_cidr        => $lan_cidr,
  tunnels         => $tunnels,
}

class { 'routing::disable::ospfd': }
class { 'routing::bgpd':
  lan_interface   => $lan_interface,
  lan_description => $lan_description,
  lan_cidr        => $lan_cidr,
  tunnels         => $tunnels,
}
```
