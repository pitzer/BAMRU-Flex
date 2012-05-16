define ngapp::deploy::monit($root_dir = $title, $type, $duser, $port) {

  $desc     = "app-${type}-${name}"
  $app_root = $root_dir
  $logfile  = "$app_root/shared/log/$env.log"
  $pidfile  = "$app_root/shared/pids/$desc.pid"
  $log_args = "--log-file $logfile" 
  $pid_args = "--pid-file $pidfile"

  file { "monitfile $root_dir" : 
    path    => "/etc/monit/conf.d/$desc.conf",
    ensure  => present,
    content => template("ngapp/via/monit_$type.erb"),
    # replace => false,
  }

  # exec { "monit reload $desc" : 
  #   path      => ["/home/$duser/.rbenv/shims", "/usr/bin", "/bin", "/home/$duser/.rbenv/bin"],
  #   command   => "bundle --binstubs",
  #   user      => $duser,
  #   group     => $duser,
  #   unless    => "[ -f $root_dir/current/procfile.lock ]",
  #   subscribe => File["procfile $root_dir"],
  # }

}
