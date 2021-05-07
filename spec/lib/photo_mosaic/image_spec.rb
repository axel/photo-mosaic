require_relative "../../spec_helper"

module PhotoMosaic

  RSpec.describe Image do
    after(:each) { Image.image_cache.clear }

    before do
      @pixels_a = [[[0, 0, 0], [0, 0, 0]], [[0, 0, 0], [0, 0, 0]]].freeze
      @pixels_b = [[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]].freeze
      @pixels_c = [[[1, 2, 3], [3, 4, 5]], [[7, 8, 9], [10, 11, 12]]].freeze
    end

    let(:image_a){ Image.new(@pixels_a) }
    let(:image_b){ Image.new(@pixels_b) }
    let(:image_c){ Image.new(@pixels_c) }

    context "#find_match" do
      it "finds the closest matching image using msd" do
        closest = image_a.find_match([image_b, image_c])
        expect(closest).to be(image_c)
      end
    end

    context "#msd" do
      it "computes the mean squared deviation between two images" do
        expect(image_a.msd(image_b)).to eq(650) # the sum of the square of their differences
      end
    end

    context "tiles" do
      it "returns an enumerator that provides successive tiles as images (row-by-row)" do
        tiles = image_b.squares(1, 2)
        expect(tiles.next.pixels).to eq([[[1, 2, 3]], [[7, 8, 9]]])
        expect(tiles.next.pixels).to eq([[[4, 5, 6]], [[10, 11, 12]]])
      end
    end

  end

end
