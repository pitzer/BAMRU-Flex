
namespace :common do

  #desc "Uname is what this is"
  task :uname do
    run "uname -a"
  end

  #desc "This is the hostname"
  task :hostname do
    run "hostname"
  end

  #desc "Whereami"
  task :whereami do
    run "pwd"
  end

end

