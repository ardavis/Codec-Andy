$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'RMagick'               # This is for image processing, to use 'get_pixels'
require 'ruby-debug'            # Used for debugging purposes
require 'shannon_fano'          # My custom Shannon-Fano Algorithm

class Encoder
  include Magick                # Include the necessary ImageMagick functions
  extend ShannonFano            # Extend my custom Shannon-Fano class

  # Ask the user for an input image
  if ARGV.size < 1
    # Reject the user without an input image
    puts "Please enter an input image."
  else

    # Loop through arguments
    ARGV.each do |argument|

      # Set the path for the input image
      image_path = argument
      image = ImageList.new(image_path)


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

      debugger

      # Put the code into the file
      open('encoded.txt', 'w') do |f|
        f.puts "Shannon-Fano\n"
        f.puts "BEGIN"

        # Get the max amount of bits for a single code
        max_length = code_hash[pixel_array[pixel_array.size - 1][0]].size
        puts "Max Bits: " + max_length.to_s

        # Loop through each of the codes and put into the file
        (0..pixel_array.size - 1).each do |index|
          current_length = code_hash[pixel_array[index][0]].size
          f.print code_hash[pixel_array[index][0]].to_s

          # Format the codes to be even columns
          if (current_length < max_length)
            (max_length - current_length).times do
              f.print " "
            end
          end

          # Print the color to match the code
          f.print " - "
          f.puts pixel_array[index][0].to_s
        end
        f.puts "END"
        f.puts "\n"
        (0..pixel_array.size - 1).each do |index|
          f.print code_hash[pixel_array[index][0]].to_s
        end
      end
    end
  end
end
