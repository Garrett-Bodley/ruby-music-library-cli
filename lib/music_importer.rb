class MusicImporter

  attr_accessor :path, :files
 
  def initialize(path=nil)
      @path = path
  end

  def path
      @path
  end

  def files
      @files = Dir.entries(@path).drop(2)
  end


  def import
      self.files.each{|file| Song.create_from_filename(file)}
  end

end