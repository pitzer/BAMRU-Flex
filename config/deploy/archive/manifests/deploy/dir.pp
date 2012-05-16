define ngapp::deploy::dir($root_dir = $title, $timestamp) {

  $dirs = "$root_dir $root_dir/releases $root_dir/shared $root_dir/shared/pids $root_dir/shared/log"
  $dira = split($dirs, ' ')

  file { $dira : 
    ensure => directory,
  }

  if link_exists("$root_dir/current") == "false" {

    file { "$root_dir/releases/$timestamp" : ensure => directory }
    file { "$root_dir/current" :
      ensure  => link,
      target  => "$root_dir/releases/$timestamp",
      require => File[$root_dir, "$root_dir/releases/$timestamp"],
    }

  }

}
