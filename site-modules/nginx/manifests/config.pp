# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx::config
class nginx::config (
  String $proxy_pass,
  String $listen_port,
  String $server_name,
) {
  file { '/etc/nginx/sites-available/reverse_proxy':
    ensure  => file,
    content => template('nginx_proxy/nginx_reverse_proxy.conf.erb'),
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/reverse_proxy':
    ensure => link,
    target => '/etc/nginx/sites-available/reverse_proxy',
    notify => Service['nginx'],
  }
}
