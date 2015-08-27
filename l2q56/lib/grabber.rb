require 'net/http'
require 'open-uri'

class Grabber
  attr_accessor :uri, :dir, :path, :images_list

  def initialize (uri = 'www.rbc.ru', dir = '/tmp', path='/')
    @uri = uri
    @dir = ".#{dir}"
    @path = path
    @images_list = {} # Создаем хеш = { имя файла => URI объект}
  end
  
  def get_images
    
    fetched_images = self.fetch_images
    images = fetched_images.scan( /<img\s+[^>]*src="([^"]*)"[^>]*>/).flatten

    images.each do |img|
      begin
        uri = URI(img.to_s)
        file = uri.path.split('/')[-1]
        self.images_list[file]=uri
      rescue URI::InvalidURIError => e
        warn e
      end
    end
    
  end

  def save_images #(grabber)
    # Можно было бы использовать Net::HTTP.start, но не факт, что все изображения находятся на одном хосте.

    Dir.mkdir(self.dir) unless Dir.exists?(self.dir)

    self.images_list.each do |filename, uri|

      if uri.class != URI::Generic
        puts "Saving file from #{uri.host} to #{dir}/#{filename}"

        File.open("#{self.dir}/#{filename}", "w") do |file|
          file.write(open(uri).read)
        end 
      end
    end
  end

  def fetch_images(limit = 10)
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    response = Net::HTTP.get_response(self.uri, self.path)

    case response
    when Net::HTTPSuccess then
      response.body
    when Net::HTTPRedirection then
      self.uri = URI(response['location']).host
      warn "redirected to #{self.uri}"
      fetch_images(limit - 1)
    else
      response.value
    end
  end

end


