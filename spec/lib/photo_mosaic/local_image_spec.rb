require_relative "../../spec_helper"

module PhotoMosaic
  TARGET_IMAGE_PATHS = %w[./spec/images/target.png ./spec/images/target2.jpg]

  RSpec.describe Image do

    after(:each) { Image.image_cache.clear }

    let(:original) { "./spec/images/target.png" }
    let(:cropped) { "./spec/images/cropped.png" }

    context "@import" do
      it "returns the same object from cache if the image was imported previously", skip_before: true do
        image = Image.import(original)
        another_image = Image.import(original)
        expect(another_image).to be(image)
      end

      it "returns an Enumerator if a collection of paths is provided", skip_before: true do
        images = Image.import([original, original])
        expect(images).to be_a_kind_of(Enumerator)
        expect(images.next).to be_a(Image)
      end

      # it "broadcasts an event when an image is imported", skip_before: true do
      #   expect { Image.import(TARGET_IMAGE_PATHS) }.to broadcast(:image_import)
      # end
    end

    context "@read" do
      it "loads an image from a local file", skip_before: true do
        image = Image.send(:read, original)
        expect(image).to be_a(Image)
      end
    end

    context "#new" do
      it "creates and assigns an underlying MiniMagick::Image if none is provided" do
        pixels = [[[0, 0, 0], [0, 0, 0]], [[0, 0, 0], [0, 0, 0]]]
        image = Image.new(pixels)
        expect(image).to be_a(Image)
        expect(image.foreign_image).to be_a(MiniMagick::Image)
      end
    end

    context "#fit" do
      it "crops by cutting along a single dimension and resizing" do
        original_image = Image.import(original)
        target_image = Image.import(cropped)
        cropped_image = original_image.fit(target_image.width, target_image.height)
        expect(cropped_image).to eq(target_image)
      end
    end
  end
end
