# Define: users::managed_user
#
define users::managed_user (
  $user  = $title,
  $group = $title,
  $shell = '/bin/bash',
  $home  = "/home/${title}",
) {
  if ! defined(Group[$group]) {
    group { $group:
      ensure => present,
    }
  }
  user { $user:
    ensure     => present,
    gid        => $group,
    home       => $home,
    shell      => $shell,
    managehome => true,
  }
  file { "${home}/.ssh":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }
}
