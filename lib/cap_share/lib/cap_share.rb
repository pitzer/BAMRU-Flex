require "cap_share/version"

require 'benchmark'
require 'yaml'
require 'capistrano'
require 'capistrano/recipes/deploy/scm'
require 'capistrano/recipes/deploy/strategy'

base_dir = File.expand_path(File.dirname(__FILE__))
Dir["#{base_dir}/cap_share/base/*.rb"].each { |p| load p }
Dir["#{base_dir}/cap_share/recipes/*.rb"].each { |p| load p }

module CapShare
  # Your code goes here...
end
