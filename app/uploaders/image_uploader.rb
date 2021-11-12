# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      small: magick.resize_to_limit!(300, 300),
      medium: magick.resize_to_limit!(1000, 1000),
      large: magick.resize_to_limit!(1800, 1800)
    }
  end
end
