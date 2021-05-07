module PhotoMosaic
  class Image
    include Wisper::Publisher
    include MiniMagickXform
    include MiniMagickIo

    attr_reader :pixels, :width, :height, :foreign_image

    def initialize(pixels, foreign_image = nil)
      @pixels = pixels
      @width = pixels.first.size
      @height = pixels.size
      @foreign_image = foreign_image
      super
    end

    def ==(other)
      pixels == other.pixels
    end

    def find_match(images)
      min_msd = nil
      closest = nil
      images.each do |other|
        msd = msd(other)
        if min_msd.nil? || msd < min_msd
          min_msd = msd
          closest = other
        end
      end
      closest
    end

    def msd(other)
      pixels_a = pixels
      pixels_b = other.pixels
      mse = 0
      pixels_a.each_with_index do |row, j|
        row.each_with_index do |pixel_a, i|
          pixel_b = pixels_b[j][i] || pixel_a
          mse += (pixel_a[0] - pixel_b[0])**2 + (pixel_a[1] - pixel_b[1])**2 + (pixel_a[2] - pixel_b[2])**2
        end
      end
      mse
    end

    def squares(tile_width, tile_height)
      tile_count = (width / tile_width) * (height / tile_height)
      Enumerator.new(tile_count) do |yielder|
        column_indexes = (0...width).to_a
        @pixels.each_slice(tile_height) do |tile_rows|
          column_indexes.each_slice(tile_width) do |tile_column_indexes|
            tile = tile_rows.map { |row| row[tile_column_indexes.first..tile_column_indexes.last] }
            yielder << self.class.new(tile)
          end
        end
      end
    end
  end
end
