set    :proxy, 'flux'
server proxy, :app, :web, :db, :primary => true

after "deploy", "ghost:remote"
after "deploy", "ghost:local"

