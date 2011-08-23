require 'rubygems'
require 'mini_magick'
require 'RMagick'

include Magick

path = "../../Images/lena512color.tiff"
image = ImageList.new(path)

# Get the pixel values of the input image
pixels = image.get_pixels(0, 0, image.columns, image.rows)


# Initialize an array of columns*rows
image_array = Array.new(image.columns) { Array.new(image.rows) { Array.new(3) {0} } }

# Print Dimensions
puts "Width: " + image.rows.to_s
puts "Height: " + image.columns.to_s
puts "# of Pixels: " + pixels.count.to_s

# Store pixels into the array
(0..(image.columns * image.rows)).each do |pixel|

end


#Array.new(512) { Array.new(512) { Array.new(3) }
#
## Loop through Red, Green, then Blue (color: 0 = red, 1 = green, 2 = blue)
#(0..2).each do |color|
#
#  # Loop through the columns of the image
#  (0..image.columns).each do |cols|
#
#    # Loop through the rows of the image
#    (0..image.rows).each do |rows|
#
#    end
#
#  end
#
#end

#(0..image.rows).each do |current_row|
  #pixels = image.export_pixels(0, 0, image.columns, 1, "RGB")
#end


#image = MiniMagick::Image.new(path)

#
#red_array = Array.new(256) { 0 }
#green_array = Array.new(256) { 0 }
#blue_array = Array.new(256) { 0 }


#print width and height
#image[:width].times do |x|
#  image[:height].times do |y|
#    p image[x, y]
#  end
#end