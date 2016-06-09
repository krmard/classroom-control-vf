class nginx (
  $docroot = '/var/www',
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  package { 'nginx':
    ensure  => present,
  }
  file { [ '/etc/nginx/conf.d', "$docroot" ]:
    ensure  => directory,
  }
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { "${docroot}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
