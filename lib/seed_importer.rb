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
    if @model.to_s == "Lecturer"
      extractor = "lecturer_extractor"
    elsif @model.to_s == "Course"
      extractor = "course_extractor"
    end
    YAML.load_file( file ).each { |seed|
      processed_data = process_data(extractor, seed)
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

  def process_data(extractor, raw_data)
    send(extractor, raw_data)
  end

  def lecturer_extractor(raw_data)
    {name: raw_data[1]}
  end

  def course_extractor(raw_data)
    {name: raw_data[1]}
  end
end
