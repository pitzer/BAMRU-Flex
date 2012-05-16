define ngapp::deploy::initd($root_dir = $title, $type, $duser, $name, $port='unix_socket') {

  $app_name = "app-${type}-${name}"

  file { "initfile $name" : 
    ensure  => present,
    path    => "/etc/init.d/${app_name}",
    content => template("ngapp/via/init_$type.erb"),
    mode    => 755,
    owner   => root,
    group   => root,
  }

  service { "$app_name" : 
    ensure    => running,
    enable    => true,
    subscribe => File["initfile $name"],
  }

  File["initfile $name"] -> Service["$app_name"]

}
