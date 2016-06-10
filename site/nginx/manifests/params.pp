class nginx::params {
	case $::osfamily {
		'redhat','debian' : {
			$package = 'nginx'
			$owner   = 'root'
			$group   = 'root'
			$confdir = '/etc/nginx'
			$logdir  = '/var/log/nginx'
			$default_docroot = '/var/www'
		}
		default   : {
			fail("Module ${module_name} is not supported on ${::osfamily}")
		}
	}
	
	$user = $::osfamily ? {
		'redhat'  => 'nginx',
		'debian'  => 'www-data',
	}
}
