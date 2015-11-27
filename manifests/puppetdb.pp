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

}
