#!/usr/bin/puppet apply 

include nginx

ngusr { "vagrant" : }

ngapp::static {'static1' : duser => 'vagrant', vhosts => ['static1'] } 
ngapp::static {'static2' : duser => 'vagrant', vhosts => ['static2'] }

ngapp::passenger {'pass1' : duser => 'vagrant', vhosts => ['pass1'], port => 8010 }
# ngapp::passenger {'pass2' : duser => 'vagrant', vhosts => ['pass2'] }

