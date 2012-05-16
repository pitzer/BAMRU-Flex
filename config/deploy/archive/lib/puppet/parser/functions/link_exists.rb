module Puppet::Parser::Functions
  newfunction(:link_exists, :type => :rvalue) do |args| 
    symlink  = args[0]
    File.exist?(symlink) ? "true" : "false"
  end
end
