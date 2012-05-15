def template(from, to, sudo = "")
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), "/tmp/_filetransfer"
  run "#{sudo} mv /tmp/_filetransfer #{to}"
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def get_host
  capture("echo $CAPISTRANO:HOST$").strip
end