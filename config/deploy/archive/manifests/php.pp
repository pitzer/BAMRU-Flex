define ngapp::php($app_name = $title, $deploy_user, $server_names, $outcome=created) {

  $conf_file = "/home/$deploy_user/a/_conf/$app_name.conf"
  $root_dir  = "/home/$deploy_user/a/$app_name"

  host { $vhosts : 
    comment      => 'php vhost',
    ensure       => 'present',
    host_aliases => ["www.$name"],
    ip           => '127.0.0.1',
  }

  File {
    owner => $deploy_user,
    group => $deploy_user,
  }

  file { $conf_file : 
    ensure  => present,
    content => template("nginx/conf_php.erb"),
  }

  file { $root_dir : ensure => directory }

  file { "$root_dir/index.php" :
    ensure  => present,
    content => "Hello World - AppName: $app_name / Deploy User: $deploy_user<br/><?php phpinfo(); ?>",
    replace => false,
  }

}
