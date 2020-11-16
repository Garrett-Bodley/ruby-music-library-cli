class Song

  attr_accessor :name
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
    save
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    self.new(name)
  end
  
  def self.new_from_filename(filename)
    input = filename.split(/ - |.mp3/)
    self.new(input[1], Artist.find_or_create_by_name(input[0]), Genre.find_or_create_by_name(input[2]))
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

  def artist= artist
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end
  
  def artist
    @artist
  end

  def genre= genre
    @genre = genre
    genre.add_song(self) unless genre.songs.include?(self)
  end

  def genre
    @genre
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name)
      find_by_name(name)
    else
      self.create(name)
    end
  end
end

# Song
#   .find_by_name
#     finds a song instance in @@all by the name property of the song (FAILED - 1)
#   .find_or_create_by_name
#     returns (does not recreate) an existing song with the provided name if one exists in @@all (FAILED - 2)
#     invokes .find_by_name instead of re-coding the same functionality (FAILED - 3)
#     creates a song if an existing match is not found (FAILED - 4)
#     invokes .create instead of re-coding the same functionality (FAILED - 5)