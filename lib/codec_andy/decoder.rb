$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'
require 'ruby-debug'
require 'check_hash'

class Decoder
  include Magick
  extend CheckHash

  # Ask the user for an input encoded file
  path = "#{File.dirname(__FILE__)}/../../encoded.txt"

  # Read the input file
  file = File.new(path, "r")

  # On the first line, get the compression method
  puts "#{file.gets.chomp}"

  # Initialize empty hashes/arrays for the pixel data and the code data
  pixel_hash = []
  code_hash = {}

  counter = 0
  while ((line = file.gets.chomp) && (line != "END"))

    unless (counter == 0)
      # Loop until "END" is found, store into a hash
      puts line
      line = line.split
      line.delete_at(1)

      code_hash[line[1]] = line[0]
    end

    counter += 1
  end

  decoded = ""
  builder = ""

  # Skip the blank line between the codes and the input string
  file.gets

  # Get the input string ready for decoding
  input = file.gets.chomp

  (0..input.size - 1).each do |index|
    #debugger
    # Add values one by one to the builder array, and check if it's a code
    builder += input[index].to_s

    # Check if the builder string is a code in the code hash
    value = check_hash(builder, code_hash)

    #debugger
    if (value != 0)
      if (decoded.empty?)
        decoded += value
      else
        decoded += "," + value
      end

      # Reset the builder string to empty
      builder = ""
    end
  end

  #[red=255, green=255, blue=255, opacity=255]

  decoded_colors = decoded.split(',').map(&:to_i)
  decoded_array = []

  n = 3

  red_array = (n - 3).step(decoded_colors.size - 3, n).map { |i| decoded_colors[i] }
  green_array = (n - 2).step(decoded_colors.size - 2, n).map { |i| decoded_colors[i] }
  blue_array = (n - 1).step(decoded_colors.size - 1, n).map { |i| decoded_colors[i] }

  #opacity = 25
  (0..((decoded_colors.size / 3) - 1)).each do |triple|
    red = red_array[triple]
    green = green_array[triple]
    blue = blue_array[triple]

    decoded_array << Magick::Pixel.new(red, green, blue, 0)
    decoded_array.reverse!

  end

  debugger

  image = ImageList.new("Images/export.png")

  size = Math.sqrt(decoded_array.size)
  image.store_pixels(0, 0, size, size, decoded_array)

  image.write("jpeg:"+ "Images/export.jpg")

  debugger

  file.close
end


# Maybe store entire coded section into a single string
# Check first character, see if it's a code
# If not, add another character to check, check if it's a code
#
# string decoded = ""
# string build = ""
# for (index = 0; index < input.length(); index++)
#  {
#    build = concat(build, input[index]);
#
#    if (checkList(build))
#        build = string.empty;
#    end
#
#  }
#
#
#  def checkList(build)
#     if build is found, add it to decoded, then return true or false if it wasn't
#  end