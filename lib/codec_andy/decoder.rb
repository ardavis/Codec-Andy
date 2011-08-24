$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'
require 'ruby-debug'

class Decoder
  include Magick

  # Ask the user for an input encoded file
  path = "#{File.dirname(__FILE__)}/../../encoded.txt"

  # Read the input file
  file = File.new(path, "r")

  counter = 0
  while (line = file.gets)

    puts "#{counter+=1}: #{line}"

  end

  file.close
end