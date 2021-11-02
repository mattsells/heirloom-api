# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

s3_options = {
  bucket: Rails.application.credentials.aws[:s3_bucket],
  region: Rails.application.credentials.aws[:s3_region],
  access_key_id: Rails.application.credentials.aws[:access_key_id],
  secret_access_key: Rails.application.credentials.aws[:secret_access_key]
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
