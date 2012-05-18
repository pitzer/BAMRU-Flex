# ====== Deployment Stages =====
set :stages,        %w(vagrant production)
set :default_stage, "vagrant"

# ===== App Config =====
set :user,        "vagrant"
set :application, "BAMRU-Flex"
set :app_name,    "flex"
set :repository,  "https://github.com/andyl/#{application}.git"
set :vhost_names, %w(flextest)
set :web_port,    9000

# ===== Stage-Specific Code (config/deploy/<stage>) =====
require 'capistrano/ext/multistage'

# ===== Common Code for All Stages =====
load 'deploy'
load 'deploy/assets'

Dir['config/deploy/base/*.rb'].each { |p| load p }
Dir['config/deploy/recipes/*.rb'].each { |p| load p }

