require_relative "../../spec_helper"

module PhotoMosaic

  RSpec.describe Mosaic do

    let(:original) { "./spec/images/target.png" }
    let(:mosaic) { "./spec/images/mosaic.png" }

    context "compose_image" do
      it "generates a photo mosaic of the target image" do
        original_image = Image.import(original)
        reference_composite = Image.import(mosaic)
        tile_width, tile_height = 100, 100
        tile_images = Image.import(Dir["./spec/images/tiles/squares_bw/*"])
        mosaic = Mosaic.new(original_image, tile_images, tile_width, tile_height)
        mosaic_image = mosaic.join_tiles
        expect(mosaic_image).to eq(reference_composite)
      end
    end

  end

end
