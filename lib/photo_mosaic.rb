require "mini_magick"
require "optimist"
require "ruby-progressbar"
require "wisper"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module PhotoMosaic
  def self.create(original_image:, tile_images:, output_image:, tile_width:, tile_height:)
    original_image = Image.import(original_image)
    tile_images = Image.import(tile_images)
    mosaic = Mosaic.new(original_image, tile_images, tile_width, tile_height)
    mosaic_image = mosaic.join_tiles
    mosaic_image.write(output_image)
    mosaic
  end

  def self.subscribe(listener)
    Wisper.subscribe(listener)
  end
end
