define ngapp::static($app_name = $title, $duser, $vhosts, $outcome=created) {

  $conf_file = "/home/$duser/a/_conf/$app_name.conf"
  $root_dir  = "/home/$duser/a/$app_name"

  File { owner => $duser, group => $duser }

  file { $conf_file : 
    ensure  => present,
    content => template("ngapp/via/conf_static.erb"),
  }

  host { $vhosts : 
    comment      => 'static vhost',
    ensure       => 'present',
    host_aliases => ["www.$name"],
    ip           => '127.0.0.1',
  }

  # '::' is a workaround - see http://projects.puppetlabs.com/issues/8174
  deploy::dir { $root_dir : timestamp => $::timestamp }   

  file { "$root_dir/current/index.html" :
    ensure  => present,
    content => "Hello World - AppType:Static / DeployUser:$duser / AppName:$app_name\n",
    replace => false,
    require => Deploy::Dir[$root_dir],
  }

}
