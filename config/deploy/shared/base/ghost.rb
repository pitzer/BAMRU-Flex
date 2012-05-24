=begin

This sets up /etc/hosts for development.
It is designed for using / testing a staging environment.

If using 'multistage', put these lines into the
config file for the staging environment.

    after "deploy", "ghost:remote"
    after "deploy", "ghost:local"

These recipes assume that the staging VM is using
bridged networking.  If using host-only networking,
replace the 'proxy' setting with the fixed-ip address.

Note: on Ubuntu if the commands don't work with sudo,
try adding these lines to /etc/sudoers:

    Defaults  env_reset
    Defaults  exempt_group=admin

=end
 
Capistrano::Configuration.instance(:must_exist).load do

  namespace :ghost do

    desc "Update /etc/hosts on remote machines using ghost"
    task :remote do
      vhost_names.each do |name|
        run "cd #{previous_release} && rbenvsudo ghost delete #{name}"
        run "cd #{previous_release} && rbenvsudo ghost add    #{name} 127.0.0.1"
      end
      run "cd #{previous_release} && rbenvsudo ghost delete #{app_name}"
      run "cd #{previous_release} && rbenvsudo ghost add    #{app_name} 127.0.0.1"
    end

    desc "Update /etc/hosts on #{`hostname`.chomp} using ghost"
    task :local do
      vhost_names.each do |name|
        system "rbenvsudo ghost delete #{name}"
        system "rbenvsudo ghost add    #{name} #{proxy}"
      end
      system "rbenvsudo ghost delete #{app_name}"
      system "rbenvsudo ghost add    #{app_name} #{proxy}"
    end

  end

end
