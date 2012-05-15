namespace :bootstrap do

  # support code to get the app running
  # after "deploy:setup", :permissions, :keysend, :deploy, :nginx_conf
  
  desc "Bootstrap the production environment"
  task :default do
    deploy.setup        # setup base directories
    deploy.update       # upload code and create 'current' symlink

    # update gems
    # install passenger
    # setup the nginx conf (for what port?)
    # foreman export
    # deploy (update code, etc.)
  end

  desc "Update gems"
  task :update_gems do
    run "echo Update gems"
  end

  desc "Set permissions."
  task :permissions do
    sudo "chown -R aleak a"
    sudo "chgrp -R aleak a"
  end

  desc "Send SSH keys to alt55.com."
  task :keysend do
    puts "No key setup needed - deploying from GitHub"
  end

  desc "Create an nginx config file."
  task :nginx_conf do
    run "cd #{current_path} && bundle exec rake nginx_conf"
  end


end
