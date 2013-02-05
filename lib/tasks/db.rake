namespace :db do
  desc "Re-Create database, db:drop, db:create, db:migrate, seed:import, db:populate"
  task recreate: ['db:drop', 'db:create', 'db:migrate', 'seed:import', 'db:populate']
end
