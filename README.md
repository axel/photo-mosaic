# PhotoMosaic
Create beautiful photo mosaics from your own images.

![Alt text](docs/img/eltz_flowers.png "Eltz Castle made of flower tiles")
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'photo_mosaic'
```

And then execute:

    $ bundle install

Or install it yourself with:

    $ gem install photo_mosaic

## Usage

```ruby
require "photo_mosaic"

PhotoMosaic.subscribe(PhotoMosaic::ProgressBar.new)

PhotoMosaic.create(
  original_image: "./images/castle.png",
  tile_images: Dir["./images/tile_images/flowers/*"],
  output_image: "./images/castle_mosaic.png",
  tile_width: 25,
  tile_height: 25
);
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/axel/photo_mosaic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/photo_mosaic/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PhotoMosaic project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/photo_mosaic/blob/master/CODE_OF_CONDUCT.md).
