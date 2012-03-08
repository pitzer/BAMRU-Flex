#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Store::Application.load_tasks

def break() puts '*' * 60 end

task :default => :msg

task :msg do
  puts "Use 'rake -T' to see rake options"
end

def end_task(msg)
  puts msg
  exit
end

desc "Import CSV data from Peer URL"
task :data_import do
  require File.dirname(File.expand_path(__FILE__)) + '/config/environment'
  sitep = Settings.new
  puts "Starting Data Import @ #{Time.now}"
  end_task "Only works with Backup Sites" if sitep.primary?
  end_task "Peer Site is undefined" if sitep.peer_url_undefined?
  url = sitep.peer_csv
  uri = URI.parse(url)
  puts "Reading CSV from #{url}..."
  csv_text = Net::HTTP.get_response(uri.host, uri.path).body
  end_task "CsvData not ready to load..." unless CsvLoader.load_ready?(csv_text)
  Event.delete_all
  puts "Loading CSV data..."
  CsvLoader.new(csv_text)
  puts "Saving CSV history..."
  CsvHistory.save
  puts "Done."
end

desc "Sync Calendar Data with Google Calendar"
task :gcal_sync do
  require File.dirname(File.expand_path(__FILE__)) + '/config/environment'
  GcalSync.sync
end

namespace :db do

  desc "Load CSV data"
  task :csv do
    Dir.glob('lib/*.rb').each {|file| load file}
    file = ENV['CSV'] || "db/csv/calendar.csv"
    require File.dirname(__FILE__) + '/config/environment'
    puts "Loading CSV Data"
    puts " > using data from '#{file}'"
    puts " > run with 'CSV=<filename>' to use another file"
    csv_load = CsvLoader.new(File.read(file))
    puts "Processed #{csv_load.num_input} records."
    #puts "Loaded #{csv_load.num_successful} records successfully."
    #ms = csv_load.num_malformed == 0 ? "" : "(view at #{MALFORMED_FILENAME})"
    #puts "Found #{csv_load.num_malformed} malformed records. #{ms}"
    #is = csv_load.num_invalid == 0 ? "" : "(view at #{INVALID_FILENAME})"
    #puts "Found #{csv_load.num_invalid} invalid records. #{is}"
  end

  desc "Show database statistics"
  task :stats => :environment do
    mc, tc = Event.meetings.count, Event.trainings.count
    ec, nc = Event.events.count, Event.non_county.count
    puts "There are a total of #{Event.count} records in the database."
    puts "(#{mc} meetings, #{tc} trainings, #{ec} events, #{nc} non-county)"
  end

end
