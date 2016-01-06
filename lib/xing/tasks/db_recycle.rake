namespace :db do
  desc "Destroy and reload the whole DB"
  task :recycle => [ :drop, :create, :migrate, :seed ]
end
