# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx::config
class nginx::config {
  file { '/etc/nginx/sites-available/reverse_proxy':
    ensure  => file,
    content => epp('nginx/nginx_reverse_proxy.conf.epp', {
        'listen_port' => $nginx::listen_port,
        'server_name' => $nginx::server_name,
        'proxy_pass'  => $nginx::proxy_pass,
    }),
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/reverse_proxy':
    ensure => link,
    target => '/etc/nginx/sites-available/reverse_proxy',
    notify => Service['nginx'],
  }
}
