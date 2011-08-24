$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'
require 'ruby-debug'
require 'shannon_fano'

class Encoder
  include Magick
  extend ShannonFano

  # Ask the user for an input image
  #puts "Please enter the relative path to an image from this directory: "
  #path =  "#{File.dirname(__FILE__)}/../../"
  #path += gets
  #
  #puts path

  # Set the path for the input image
  path = "#{File.dirname(__FILE__)}/../../Images/lena512color.tiff"
  image = ImageList.new(path)

  # Get the pixel values of the input image
  pixels = image.get_pixels(0, 0, image.columns, image.rows)

  # Initialize empty hashes for the pixel data and the code data
  pixel_hash = {}
  code_hash = {}

  # Store pixels into the array

  (0..image.rows-1).each do |row|
    (0..image.columns-1).each do |col|
      # Grab the current pixel
      current_pixel = (row * image.columns) + col

      # Get the RGB values of the current_pixel
      red   = pixels[current_pixel].red
      green = pixels[current_pixel].green
      blue  = pixels[current_pixel].blue

      # Add the current pixel value to the hash if it doesn't exist, otherwise, increment it
      if pixel_hash.key?("" + red.to_s + "," + green.to_s + "," + blue.to_s + "")
        pixel_hash[(red.to_s + "," + green.to_s + "," + blue.to_s)] += 1
      else
        pixel_hash[(red.to_s + "," + green.to_s + "," + blue.to_s)] = 1
      end
    end
  end

  # Sort the hash of pixels to get the largest value at the front
  pixel_hash = pixel_hash.sort_by {|k,v| -v}

  # Convert the hash into an array to be used in the shannon_fano algorithm
  pixel_array = pixel_hash.to_a

  # Get the codes for each pixel using the shannon_fano method
  code_hash = shannon_fano(pixel_array, code_hash)

  # Put the code into the file
  open('encoded.txt', 'w') do |f|
    f.puts "Shannon-Fano\n"
    (0..pixel_array.size - 1).each do |index|
      f.puts pixel_array[index][0].to_s + " - " + code_hash[pixel_array[index][0]].to_s
    end
    f.puts "\n"
    (0..pixel_array.size - 1).each do |index|
      f.print code_hash[pixel_array[index][0]].to_s
    end
  end
end
