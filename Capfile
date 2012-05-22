require 'rubygems'
require 'bundler/setup'

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
require 'cap_share'

# ===== Package Definitions =====
require "cap_share/packages/nginx"
require "cap_share/packages/foreman"

#load "cap_share/packages/postgresql"
#load "cap_share/packages/unicorn"
#load "cap_share/packages/nodejs"
#load "cap_share/packages/rbenv"
#load "cap_share/packages/check"

