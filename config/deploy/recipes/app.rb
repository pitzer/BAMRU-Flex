desc "Run the App Console"
task :console do
  system "ssh -t #{proxy} tmux_console #{current_path}/script/tmpro"
end
