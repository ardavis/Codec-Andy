$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'
require 'ruby-debug'
require 'shannon_fano'

class CodecAndy
  include Magick
  extend ShannonFano


  path = "#{File.dirname(__FILE__)}/../../Images/8-bit-link.png"
  image = ImageList.new(path)

  # Get the pixel values of the input image
  pixels = image.get_pixels(0, 0, image.columns, image.rows)

  pixel_hash = {}
  code_hash = {}

  # Store pixels into the array

  (0..image.rows-1).each do |row|
    (0..image.columns-1).each do |col|
      # Grab the current pixel
      current_pixel = (row * image.rows) + col

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

  # Split the pixel_hash into two parts
  pixel_array = pixel_hash.to_a

  code_hash = shannon_fano(pixel_array, code_hash)

  #pivot   = pixel_hash.size / 2
  #column_1 = pixel_array[0, pivot]
  #column_2 = pixel_array[pivot..pixel_array.size - 1]
  #column_1.each do |array|
  #  code_hash[array[0].to_s] = "0"
  #end
  #
  #
  #column_2.each do |array|
  #  code_hash[array[0].to_s] = "1"
  #end

  puts code_hash

  # TODO Remove
  debugger

  (0..1).each do |bla|
    puts bla
  end
end