module PhotoMosaic
  class Mosaic
    include Wisper::Publisher

    def initialize(original_image, tile_images, tile_width, tile_height)
      @tile_width = tile_width
      @tile_height = tile_height
      @original_image = original_image.shave(original_image.width % tile_width, original_image.height % tile_height)
      @tile_images = tile_images.map { |img| img.fit(tile_width, tile_height) }
    end

    def join_tiles
      rows = []
      tiles.each_with_index do |tile, index|
        row_index = index / width
        rows[row_index] = if rows[row_index].nil?
          tile.pixels
        else
          merge_pixels(rows[row_index], tile.pixels)
        end
      end
      Image.new(rows.reduce(&:+))
    end

    def height
      @original_image.height / @tile_height
    end

    def size
      width * height
    end

    def tiles
      squares = @original_image.squares(@tile_width, @tile_height)
      Enumerator.new do |yielder|
        squares.each do |square|
          yielder << square.find_match(@tile_images)
          broadcast(:image_find_match, {broadcaster: self, total: size})
        end
      end
    end

    def width
      @original_image.width / @tile_width
    end

    private

    def merge_pixels(pixels_a, pixels_b)
      pixels_a.each_with_index.map do |row, index|
        row + (pixels_b[index])
      end
    end
  end
end
