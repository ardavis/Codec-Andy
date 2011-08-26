#######################################################
#           decoder.rb
#
# Author: Andrew R. Davis
# School: Kettering University
#
# This decoder is meant to read an encoded file and
# spit out a jpg image.
#
#######################################################

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'
require 'ruby-debug'
require 'check_hash'

class Decoder
  include Magick
  extend CheckHash

  # Ask the user for an input encoded file
  path = "#{File.dirname(__FILE__)}/encoded.txt"

  # Read the input file
    file = File.new(path, "r")

  # On the first line, get the compression method
  puts "#{file.gets.chomp}"

  # Initialize empty hash for the code data
  code_hash = {}

  counter = 0
  while ((line = file.gets.chomp) && (line != "END"))

    unless (counter == 0)
      # Loop until "END" is found, store into a hash
      puts line
      line = line.split
      line.delete_at(1)

      code_hash[line[0]] = line[1]
    end

    counter += 1
  end

  decoded = []
  builder = ""

  # Skip the blank line between the codes and the input string
  file.gets

  # Get the input string ready for decoding
  input = file.gets.chomp

  (0..input.size - 1).each do |index|
    # Add values one by one to the builder array, and check if it's a code
    builder += input[index].to_s

    # Check if the builder string is a code in the code hash
    value = code_hash[builder]

    if (!value.nil?)
      value += ",65535"
      rgb = value.split(',').map(&:to_i)
      decoded << Pixel.new(rgb[0], rgb[1], rgb[2], rgb[3])
      # Reset the builder string to empty
      builder = ""
    end
  end

  #[red=255, green=255, blue=255, opacity=255]

  # Get the size of the image (Image MUST be a Square in this case!!)
  size = Math.sqrt(decoded.size).to_i
  image = Magick::ImageList.new

  # Create a new image
  image.new_image(size, size)

  # Store the pixels to the image
  image.store_pixels(0, 0, size, size, decoded)

  # Write the image to a file
  image.write("jpeg:"+ "export.jpg")

  # Close the image
  file.close
end