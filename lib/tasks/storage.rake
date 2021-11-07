# frozen_string_literal: true

namespace :storage do
  desc 'Remove olds cached images from cloud storage'
  task clean: :environment do
    if Rails.env.production?
      cache = Shrine.storages[:cache]

      one_week_in_seconds = 7 * 24 * 60 * 60

      cache.clear! { |object| object.last_modified < Time.current - one_week_in_seconds }
    else
      puts 'Cache can only be cleared in production'
    end
  end
end
