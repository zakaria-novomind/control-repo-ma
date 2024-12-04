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

class { 'nginx':
  proxy_pass  => 'http://3.73.125.5:80',
  listen_port => '80',
  #server_name => $trusted['certname'],
  server_name => 'nginx.tf.aws.nmop.de',
}
