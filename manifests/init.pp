# == Class: routing
#
# Full description of class routing here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { routing:
#  }
#
# === Authors
#
# Jonathan Creasy <jonathan.creasy@gmail.com>
#
# === Copyright
#
# Copyright 2013 Jonathan Creasy, unless otherwise noted.
#
class routing {
  package { 'quagga':
    ensure => installed,
  }
}
