require "seed_importer.rb"
namespace :seed do
  desc "Import master datas in 'db/masters'"
  task import: :environment do    
    SeedImporter.new.run
  end
end
