define ngapp::passenger($app_name = $title, $duser, $vhosts, $port='unix_socket') {

  $conf_file = "/home/$duser/a/_conf/$app_name.conf"
  $root_dir  = "/home/$duser/a/$app_name"

  File { owner => $duser, group => $duser }

  file { $conf_file : 
    ensure  => present,
    content => template("ngapp/via/conf_passenger.erb"),
    before  => Ngapp::Deploy::Initd[$root_dir],
  }

  # '::' is a workaround - see http://projects.puppetlabs.com/issues/8174
  ngapp::deploy::dir { $root_dir : timestamp => $::timestamp }

  ngapp::deploy::gem { $root_dir : 
    duser   => $duser,
    type    => 'passenger',
    require => Ngapp::Deploy::Dir[$root_dir],
  }

  host { $vhosts : 
    comment      => 'passenger vhost',
    ensure       => 'present',
    host_aliases => ["www.$name"],
    ip           => '127.0.0.1',
  }

  file { "$root_dir config":
    path    => "$root_dir/current/config.ru",
    ensure  => present,
    content => template('ngapp/config.ru.erb'),
    replace => false,
    require => Ngapp::Deploy::Dir[$root_dir],
  }

  file { ["$root_dir/current/public", "$root_dir/current/tmp"] :
    ensure  => directory,
    require => File["$root_dir config"],
  }

  file { ["$root_dir/current/public/index.html", "$root_dir/current/tmp/restart.txt"] :
    content => "Hello World - AppType:Passenger / DeployUser:$duser / AppName:$app_name\n",
    require => File["$root_dir/current/public", "$root_dir/current/tmp"],
  }

  ngapp::deploy::monit { $root_dir :
    duser => $duser,
    port  => $port,
    type  => "passenger",
    name  => $app_name,
    require => File["$root_dir/current/public/index.html", "$root_dir/current/tmp/restart.txt"],
  }

  ngapp::deploy::initd { $root_dir : 
    duser   => $duser,
    port    => $port,
    type    => "passenger",
    name    => $app_name,
    require => File["$root_dir/current/public/index.html", "$root_dir/current/tmp/restart.txt"],
  } 

}
