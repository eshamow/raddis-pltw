class pltw::puppetdb {

  include nginx

  class { 'puppetdb':
    disable_ssl => true,
  }

  class { 'selinux':
    mode => 'disabled',
  }

  nginx::resource::upstream { 'puppetdb-app':
    members => ['localhost:8080'],
  }

  openssl::certificate::x509 { $::fqdn:
    country      => 'US',
    organization => 'BEH',
    commonname   => $::fqdn,
    base_dir     => '/etc/ssl/certs',
    notify       => Nginx::Resource::Vhost['puppetdb-proxy'],
  }

  nginx::resource::vhost { 'puppetdb-proxy':
    proxy       => 'http://puppetdb-app',
    listen_port => 8081,
    ssl_port    => 8081,
    ssl         => true,
    ssl_cert    => "/etc/ssl/certs/${::fqdn}.crt",
    ssl_key     => "/etc/ssl/certs/${::fqdn}.key",
  }

  firewall { '100 Allow inbound PuppetDB (v4)':
    dport  => 8081,
    proto  => 'tcp',
    action => 'accept',
  }

  #################
  ## Puppetboard ##
  #################

  include git
  include apache
  include puppetboard

  class { 'puppetboard::apache::vhost':
    vhost_name => '*',
    port       => '80',
  }

  class { 'apache::mod::wsgi':
    wsgi_socket_prefix => "/var/run/wsgi",
  }

}
