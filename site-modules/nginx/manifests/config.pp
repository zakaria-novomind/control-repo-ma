# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx::config
class nginx::config {
  file { "/etc/nginx/sites-available/${nginx::server_name}":
    ensure  => file,
    content => epp('nginx/nginx_reverse_proxy.conf.epp', {
        'listen_port' => $nginx::listen_port,
        'server_name' => $nginx::server_name,
        'proxy_pass'  => $nginx::proxy_pass,
    }),
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => epp('nginx/default.epp'),
    notify  => Service['nginx'],
  }

  file { "/etc/nginx/sites-enabled/${nginx::server_name}":
    ensure => link,
    target => "/etc/nginx/sites-available/${nginx::server_name}",
    notify => Service['nginx'],
  }

  # file { '/etc/letsencrypt/fullchain.pem':
  #   ensure => file,
  # source   => 'puppet:///modules/nginx/fullchain.pem', }

  # file { '/etc/letsencrypt/privkey.pem':
  #   ensure => file,
  #   source => 'puppet:///modules/nginx/privkey.pem',
  # }
}
