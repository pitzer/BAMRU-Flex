require 'rubygems'
require 'bundler/setup'
require File.expand_path('./lib/env_settings', File.dirname(__FILE__))

# ===== App Config =====
set :app_name,    "bflex"
set :application, "BAMRU-Flex"
set :repository,  "https://github.com/andyl/#{application}.git"
set :vhost_names, %w(flex.bamru.info bflex bflextest)
set :web_port,    9000

# ===== Stage Specific Code =====
set :stages,        %w(vagrant devstage pubstage production)
set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

# ===== Common Code for All Stages =====
load 'deploy'
share_dir = File.expand_path("config/deploy/shared", File.dirname(__FILE__))
require "#{share_dir}/tasks"

# ===== Package Definitions =====
require share_dir + "/packages/passenger"
require share_dir + "/packages/foreman"
require share_dir + "/packages/sqlite"

