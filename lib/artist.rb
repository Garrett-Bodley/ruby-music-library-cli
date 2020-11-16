class Artist

  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self unless song.artist
  end

  def genres
    @songs.collect{|song| song.genre}.uniq
  end

end

# Associations — Artist and Genre:
#   Artist
#     #genres
#       returns a collection of genres for all of the artist's songs (artist has many genres through songs) (FAILED - 1)
#       does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs) (FAILED - 2)
#       collects genres through its songs instead of maintaining its own @genres instance variable (artist has many genres through songs)
#   Genre
#     #artists
#       returns a collection of artists for all of the genre's songs (genre has many artists through songs) (FAILED - 3)
#       does not return duplicate artists if the genre has more than one song by a particular artist (genre has many artists through songs) (FAILED - 4)
#       collects artists through its songs instead of maintaining its own @artists instance variable (genre has many artists through songs)