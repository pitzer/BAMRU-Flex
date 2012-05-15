namespace :depxt do

  desc "Deploy #{application}"
  deploy.task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Update gem installation."
  task :update_gems do
    current_host = get_host
    puts "C"
    system "bundle pack"
    system "cd vendor ; rsync -a --delete cache #{current_host}:a/#{appdir}/shared"
    run "cd #{release_path} ; bundle install --quiet --local --path=/home/aleak/.gems"
  end

  desc "RUN THIS FIRST!"
  task :first_deploy do
    check_for_passenger
    current_host = get_host
    run "mkdir -p /home/aleak/a"
    run "mkdir -p /home/aleak/a/_conf"
    run "gem install rspec"
    deploy.setup
    run "mkdir -p #{shared_path}/db"
    run "mkdir -p #{shared_path}/data"
    system "/home/aleak/util/bin/vhost add #{current_host}"
    puts "READY TO RUN on #{current_host}"
  end

  after :deploy, :update_gems, :setup_shared_cache, :setup_primary, :setup_backup
  after "deploy:symlink", :reset_cron, :link_shared
  after :nginx_conf, :restart_nginx

  desc "Reset Cron"
  task :reset_cron do
    #run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end

  desc "Setup shared cache."
  task :setup_shared_cache do
    cache_dir = "#{shared_path}/cache"
    vendor_dir = "#{release_path}/vendor"
    run "mkdir -p #{cache_dir} #{vendor_dir}"
    run "ln -s #{cache_dir} #{vendor_dir}/cache"
    run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  end

  def remote_file_exists?(full_path)
    'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
  end

  desc "Link shared assets."
  task :link_shared do
    db_file = "production.sqlite3"
    unless remote_file_exists?("#{shared_path}/db/#{db_file}")
      puts " creating DB file ".center(80, '-')
      run "mkdir -p #{shared_path}/db"
      run "cp #{release_path}/db/database.sqlite3 #{shared_path}/db/#{db_file}"
    end
    unless remote_file_exists?("#{shared_path}/data/settings.yaml")
      puts " creating settings file ".center(80, '-')
      run "mkdir -p #{shared_path}/data"
      run "cp -r #{release_path}/data/shared/* #{shared_path}/data"
    end
    run "rm -f #{release_path}/db/#{db_file}"
    run "ln -s #{shared_path}/db/#{db_file} #{release_path}/db/#{db_file}"
    run "mv #{release_path}/data/shared #{release_path}/data/shared_save"
    run "ln -s #{shared_path}/data #{release_path}/data/shared"
    run "touch #{release_path}/tmp/restart.txt"
  end

  desc "Restart NGINX."
  task :restart_nginx do
    sudo "/etc/init.d/nginx restart"
  end

  desc "Setup Primary site."
  task :setup_primary, :roles => [:primary] do
    #if defined?(PRIMARY)
    #  run "cd #{current_path} ; bundle exec rake set_primary_role"
    #  url = defined?(BACKUP) ? "http://#{BACKUP}" : ""
    #  run "cd #{current_path} ; bundle exec rake set_peer PEER_URL=#{url}"
    #end
  end

  desc "Setup Backup site."
  task :setup_backup, :roles => [:backup] do
    if defined?(BACKUP)
      run "cd #{current_path} ; bundle exec rake set_backup_role"
      url = defined?(PRIMARY) ? "http://#{PRIMARY}" : ""
      run "cd #{current_path} ; bundle exec rake set_peer PEER_URL=#{url}"
    end
  end

  def remote_file_exists?(full_path)
    'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
  end

  namespace :check do
    desc "Make sure local git is in sync with remote."
    task :revision, roles: :web do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
        puts "WARNING: HEAD is not the same as origin/#{branch}"
        puts "Run `git push` to sync changes."
        exit
      end
    end
    before "deploy", "depxt:check:revision"
    before "deploy:migrations", "depxt:check:revision"
    before "deploy:cold", "depxt:check:revision"
  end

  task :check_for_passenger do
    current_host = get_host
    error_msg = <<-EOF

    ABORT: PLEASE INSTALL PASSENGER, THEN TRY AGAIN !!!
    sys sw install:passenger host=#{current_host}

    EOF
    abort error_msg unless remote_file_exists?("/etc/init.d/nginx")
  end

end
