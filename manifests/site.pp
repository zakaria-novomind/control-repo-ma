## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
node /agent/ {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }

  class { 'nginx':
    proxy_pass  => 'http://172.31.33.45:80',
    listen_port => '80',
    #server_name => $trusted['certname'],
    server_name => 'nginx.tf.aws.nmop.de',
  }
  class { 'letsencrypt':
    email => 'zermani@th-brandenburg.de',
  }
  # letsencrypt::certonly { 'nginx.tf.aws.nmop.de':

  #   manage_cron          => true,
  #   cron_hour            => [0,12],
  #   cron_minute          => '30',
  #   cron_before_command  => '/bin/systemctl stop nginx.service',
  #   cron_success_command => '/bin/systemctl reload nginx.service',
  #   cron_output          => 'suppress',
  # }
  letsencrypt::certonly { 'nginx.tf.aws.nmop.de': }
}
node 'pp.web.org' {
  class { 'apache': }
}
