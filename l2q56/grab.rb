require "./lib/grabber"

grab = Grabber.new( ARGV[0], ARGV[1] )
puts "Recieving images from #{grab.uri}"
grab.get_images
puts "And saving to local #{grab.dir}"
grab.save_images
puts "Finished, images are saved"