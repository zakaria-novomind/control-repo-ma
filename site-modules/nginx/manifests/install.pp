# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx::install
class nginx::install {
  package { 'nginx':
    ensure => installed,
  }
}
