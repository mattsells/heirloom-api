# frozen_string_literal: true

module Support
  module Attachments
    module_function

    def image_data
      attachment_data(uploaded_image)
    end

    def video_data
      attachment_data(uploaded_video)
    end

    def attachment_data(attachment)
      attacher = Shrine::Attacher.new
      attacher.set(attachment)

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

    def uploaded_video
      path = Rails.root.join('spec/files/video.mp4')
      file = File.open(path, binmode: true)

      uploaded_file = Shrine.upload(file, :cache, metadata: false)

      uploaded_file.metadata.merge!(
        size: File.size(file.path),
        mime_type: 'video/mp4',
        filename: 'video.mp4'
      )

      uploaded_file
    end
  end
end
