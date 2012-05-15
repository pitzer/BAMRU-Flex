namespace :app do

  desc "Deploy #{application}"
  task :deploy do
    run "echo Deploy"
  end

  desc "Rollback #{application}"
  task :rollback do
    run "echo Rollback"
  end

  desc "Setup #{application}"
  task :setup do
    run "echo Setup"
  end

  desc "Start #{application}"
  task :start do
    run "echo Start"
  end

  desc "Status for #{application}"
  task :status do
    run "echo Status"
  end

  desc "Stop #{application}"
  task :stop do
    run "echo Stop"
  end

  namespace :web do

    desc "Enable web interface for #{application}"
    task :enable do
      run "echo Enable"
    end

    desc "Disable web interface for #{application}"
    task :disable do
      run "echo Disable"
    end

  end

end
