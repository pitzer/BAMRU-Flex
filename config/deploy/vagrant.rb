set    :proxy, 'flex'
server proxy, :app, :web, :db, :primary => true

after "deploy", "ghost:remote"
after "deploy", "ghost:local"

