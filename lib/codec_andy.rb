require 'rubygems'
require 'mini_magick'

path = "/Users/ardavis/Pictures/Atlantis/Andy_Crawler.jpg"
image = MiniMagick::Image.new(path)

#print width and height
puts image[:width]
puts image[:height]
