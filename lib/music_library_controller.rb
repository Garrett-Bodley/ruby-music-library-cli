require_relative '../config/environment'

class MusicLibraryController

  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    options = ['list songs', 'list artists', 'list artist', 'list genres', 'list genre', 'play song', 'exit']
    input = ""
    input = gets.chomp
    binding.pry
    until options.include?(input)
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp
    end

    case

    when input == 'list songs'
      list_songs
    when input == 'list artists'
      list_artists
    when input == 'list artist'
      list_songs_by_artist
    when input == 'list genres'
      list_genres
    when input == 'list genre'
      list_songs_by_genre
    when input = 'play song'
      play_song
    when input == 'exit'
      return 'exit'
    else 
      call
    end
  end

  def list_songs
    songs = Song.all
    songs.sort{|a, b| a.name <=> b.name}.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    artists = Artist.all
    artists.sort{|a, b| a.name <=> b.name}.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    if Artist.find_by_name(input)
      Artist.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each_with_index{|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    if Genre.find_by_name(input)
      Genre.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each_with_index{|song, index| puts"#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list_songs
    input = Integer(gets) rescue false
    if input && input <= Song.all.count && input > 0
      puts "Playing #{Song.all.sort{|a, b| a.name <=> b.name}[input-1].artist.name} - #{Song.all.sort{|a, b| a.name <=> b.name}[input-1].name}"
    end
  end
  
end