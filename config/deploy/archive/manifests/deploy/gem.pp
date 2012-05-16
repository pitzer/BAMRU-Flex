define ngapp::deploy::gem($root_dir = $title, $type, $duser) {

  file { "gemfile $root_dir" : 
    path    => "$root_dir/current/Gemfile",
    ensure  => present,
    content => template("ngapp/via/gem_$type.erb"),
    replace => false,
    require => Ngusr[$duser],
    before  => Ngapp::Deploy::Initd[$root_dir],
  }

  $hmdir = "/home/$duser"
  $hpath = ["$hmdir/.rbenv-usergems/shims", "/usr/bin", "/bin", "/opt/rbenv/bin", "$hmdir/util/base_util/bin"]

  Exec { path => $hpath }

  exec { "rhsh $root_dir" :
    user      => $duser,
    group     => $duser,
    command   => "rhsh",
    logoutput => true,
    unless    => "[ -f $hmdir/.rbenv-usergems/shims/bundle ]",
    before    => Exec["bundle $root_dir"],
  }

  exec { "bundle $root_dir" : 
    cwd       => "$root_dir/current",
    command   => "bundlebin $hmdir",
    # command   => "bundle --binstubs",
    user      => $duser,
    group     => $duser,
    timeout   => 0,
    tries     => 3,
    try_sleep => 5,
    logoutput => true,
    unless    => "[ -f $root_dir/current/Gemfile.lock ]",
    require   => File["gemfile $root_dir"],
  }

}
