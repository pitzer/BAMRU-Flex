set :scm,        :git
set :appdir,     application
set :deploy_via, :remote_cache
set :deploy_to,  "/home/#{user}/a/#{application}"
set :use_sudo,   false

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# ---------------------------------------------------------------------------------
# see http://henriksjokvist.net/archive/2012/2/deploying-with-rbenv-and-capistrano/
require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"


