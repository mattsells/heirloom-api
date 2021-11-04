# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

s3_options = {
  bucket: ENV['AWS_S3_BUCKET'],
  region: ENV['AWS_S3_REGION'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
}

Shrine.storages = if Rails.env.production?
                    {
                      cache: Shrine::Storage::S3.new(prefix: 'uploads/cache', **s3_options),
                      store: Shrine::Storage::S3.new(prefix: 'uploads/cache', **s3_options)
                    }
                  elsif Rails.env.development?
                    {
                      cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
                      store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
                    }
                  else
                    {
                      cache: Shrine::Storage::Memory.new,
                      store: Shrine::Storage::Memory.new
                    }
                  end

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :upload_endpoint, url: true

# Custom plugins
Shrine.plugin LocalHost
