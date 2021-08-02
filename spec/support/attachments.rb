# frozen_string_literal: true

module Support
  module Attachments
    module_function

    def image_data
      attacher = Shrine::Attacher.new
      attacher.set(uploaded_image)

      attacher.column_data
    end

    def uploaded_image
      path = Rails.root.join('spec/files/image.jpeg')
      file = File.open(path, binmode: true)

      uploaded_file = Shrine.upload(file, :cache, metadata: false)

      uploaded_file.metadata.merge!(
        size: File.size(file.path),
        mime_type: 'image/jpeg',
        filename: 'image.jpeg'
      )

      uploaded_file
    end
  end
end
