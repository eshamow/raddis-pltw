class pltw::puppetdb {

  include puppetdb
  include nginx

  nginx::resource::upstream { 'puppetdb':
    members => ['localhost:8080'],
  }

  nginx::resource::vhost { 'puppetdb':
    proxy       => 'http://puppetdb',
    listen_port => 8081,
    ssl_port    => 8081,
    ssl         => true,
  }

}
