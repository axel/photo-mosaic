# frozen_string_literal: true

module PhotoMosaic
  class Parser
    def self.tokenize(_args)
      opts = Optimist.options do
        opt :original, 'Original Image', type: :string
        opt :tiles, 'Tile Images', type: :string
        opt :output, 'Output File', type: :string
        opt :tile_width, 'Tile Width', default: 20
        opt :tile_height, 'Tile Height', default: 20
      end
      Optimist.die :original, 'must be specified' if opts[:original].nil?
      opts
    end

    def self.run(args)
      opts = tokenize(args)
      PhotoMosaic.subscribe(PhotoMosaic::ProgressBar.new)
      begin
        PhotoMosaic.create(
          original_image: opts[:original],
          tile_images: Dir["#{opts[:tiles]}/*"],
          output_image: opts[:output],
          tile_width: opts[:tile_width],
          tile_height: opts[:tile_height]
        )
      rescue Exception => e
        puts e.message
        exit false
      end
    end
  end
end
