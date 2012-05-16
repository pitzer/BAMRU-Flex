define ngapp::deploy::proc($root_dir = $title, $type, $duser, $port) {

  $env      = "production"
  $desc     = "app-$type-$name"
  $tcp_port = $port
  $unx_port = "/tmp/$name.socket"
  $usr_name = $duser
  $app_root = $root_dir
  $log_args = "--log-file $app_root/shared/log/$env.log"
  $pid_args = "--pid-file $app_root/shared/pids/$desc.pid"

  $connect_method = $tcp_port ? {
    "unix_socket" => "-S $unx_port",
    default       => "-p $tcp_port",
  }

  $passenger_arg = "$connect_method -e $env -R config.ru -d -$log_args $pid_args"
  file { "procfile $root_dir" : 
    path    => "$root_dir/current/Procfile",
    ensure  => present,
    content => template("ngapp/via/proc_$type.erb"),
    replace => false,
  }

  # exec { "foreman $root_dir" : 
  #   cwd     => "$root_dir/current",
  #   path    => ["/home/$duser/.rbenv/shims", "/usr/bin", "/bin", "/home/$duser/.rbenv/bin"],
  #   command => "bundle --binstubs",
  #   user    => $duser,
  #   group   => $duser,
  #   unless  => "[ -f $root_dir/current/procfile.lock ]",
  #   require => File["procfile $root_dir"],
  # }

}
