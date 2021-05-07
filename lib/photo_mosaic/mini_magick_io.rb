module PhotoMosaic
  module MiniMagickIo
    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end

    module ClassMethods
      include Wisper::Publisher

      def import(image_path)
        image_paths = Array(image_path)
        images = Enumerator.new(image_paths.size) do |yielder|
          image_paths.each do |path|
            image = read(path)
            if image_paths.size > 1
              broadcast(:image_import, {broadcaster: self, paths: image_paths, current_path: path})
            end
            yielder << image
          end
        end
        images.size > 1 ? images : images.first
      end

      def read(path)
        image = image_cache[path]
        if image.nil?
          foreign_image = MiniMagick::Image.open(path)
          pixels = foreign_image.get_pixels
          image = new(pixels, foreign_image)
          image_cache[path] = image
        end
        image
      end

      def image_cache
        @image_cache ||= {}
      end
    end

    module InstanceMethods
      def initialize(pixels, foreign_image = nil)
        @foreign_image = foreign_image || export(pixels)
      end

      def write(path)
        foreign_image.write(path)
        self
      end

      def export(pixels)
        dimension = [pixels.first.size, pixels.size]
        map = "rgb"
        depth = 8
        mime_type = "png"
        MiniMagick::Image.get_image_from_pixels(pixels, dimension, map, depth, mime_type)
      end
    end
  end
end
