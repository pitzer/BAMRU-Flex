puts ' PRODUCTION '.center(70, '-')

set :user,      "deploy"
set :proxy,     "bamru1"
set :branch,    fetch(:branch, "master")
set :rails_env, fetch(:env,    "production")

server proxy, :app, :web, :db, :primary => true

before "deploy:restart", :precompile_assets

task :precompile_assets do
  run "cd #{release_path}; rake assets:precompile"
end
