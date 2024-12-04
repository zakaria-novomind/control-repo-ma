# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx::service
class nginx::service {
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    provider   => 'systemd',
  }
}
