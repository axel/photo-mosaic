module PhotoMosaic
  module MiniMagickXform
    def self.included(base)
      base.include InstanceMethods
    end

    module InstanceMethods
      def fit(target_width, target_height)
        x_offset, y_offset = 0, 0
        crop_width, crop_height = width, height
        target_aspect_ratio = target_width.fdiv(target_height)
        self_aspect_ratio = width.fdiv(height)
        if target_aspect_ratio < self_aspect_ratio
          crop_width = (target_aspect_ratio * height).round
          x_offset = (width - crop_width) / 2
        elsif target_aspect_ratio > self_aspect_ratio
          crop_height = (target_height.fdiv(target_width) * width).round
          y_offset = (height - crop_height) / 2
        end
        # noinspection RubyResolve
        foreign_image.crop("#{crop_width}x#{crop_height}+#{x_offset}+#{y_offset}")
        resize(target_width, target_height)
        initialize(foreign_image.get_pixels, foreign_image)
        self
      end

      def resize(width, height)
        foreign_image.resize("#{width}x#{height}")
        initialize(foreign_image.get_pixels, foreign_image)
        self
      end

      def shave(x_shave, y_shave)
        target_width = width - x_shave
        target_height = height - y_shave
        # noinspection RubyResolve
        foreign_image.crop("#{target_width}x#{target_height}+0+0")
        initialize(foreign_image.get_pixels, foreign_image)
        self
      end
    end
  end
end
