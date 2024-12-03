# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx
class nginx (
  String $proxy_pass,
  String $listen_port = '80',
String $server_name = '_',) {
  contain nginx::install
  contain nginx::config
  contain nginx::service

  Class['nginx::install'] -> Class['nginx::config'] ~> Class['nginx::service']
}
