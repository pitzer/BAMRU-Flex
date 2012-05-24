require 'rubygems'
require 'bundler/setup'

# ====== Deployment Stages =====
set :stages,        %w(staging production)
set :default_stage, "staging"
set :user,          "aleak"
set :proxy,         "vv1"

# ===== App Config =====
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
base_dir = File.expand_path(File.dirname(__FILE__))
Dir.glob("config/deploy/shared/base/*.rb").each {|f| require base_dir + '/' + f}
Dir.glob("config/deploy/shared/recipes/*.rb").each {|f| require base_dir + '/' + f}

# ===== Package Definitions =====
require base_dir + "/config/deploy/shared/packages/nginx"
require base_dir + "/config/deploy/shared/packages/foreman"
require base_dir + "/config/deploy/shared/packages/sqlite"

#load "cap_share/packages/postgresql"
#load "cap_share/packages/unicorn"
#load "cap_share/packages/nodejs"
#load "cap_share/packages/rbenv"
#load "cap_share/packages/check"

