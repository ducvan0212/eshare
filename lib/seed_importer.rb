class SeedImporter
  def initialize
    @model = nil
    @with_id = false
  end

  def run
    Dir.glob( Rails.root.to_s + '/db/seeds/**/*.{yml}' ).sort.each { |seed|
      send( "import_#{File.extname( seed )[1..seed.bytesize]}_seed", seed )
    }
  end

  def import_yml_seed( file )
    init_model( file, '.yml' )
    YAML.load_file( file ).each { |seed|
      processed_data = process_data("lecturer_extracter", seed)
      create_and_save(processed_data)
    }
  end

  def init_model( file, suffix )
    @model = (to_model( file, suffix )).constantize
  end

  def to_model( file, suffix )
    File.basename( file, suffix ).sub( /\A[0-9]+(_\.)?/, '' ).classify
  end

  def create_and_save( data )
    @model.create!( data )
  end

  def process_data(extracter, raw_data)
    send(extracter, raw_data)
  end

  def lecturer_extracter(raw_data)
    {name: raw_data[1]}
  end
end
