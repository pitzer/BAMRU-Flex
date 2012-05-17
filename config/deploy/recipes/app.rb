desc "Run the App Console"
task :console do
  system "ssh -t #{proxy} #{current_path}/script/tmpro"
end
