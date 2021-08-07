# frozen_string_literal: true

seeds = []

if Rails.env.production?
  seeds << :production
elsif Rails.env.development?
  seeds.concat %i[production development]
end

seeds.each do |env|
  env_path = Rails.root.join("db/#{env}")
  manifest_path = File.join(env_path, 'manifest.yml')

  manifest = YAML.safe_load(File.open(manifest_path))

  next if manifest.blank?

  manifest.each do |resource|
    next if resource.blank?

    load File.join(env_path, "#{resource}.rb")
  end
end

# rubocop:disable Rails/Output
puts "Created #{Account.count} accounts"
puts "Created #{User.count} users"
puts "Created #{Recipe.count} recipes"
puts "Created #{Story.count} recipes"
# rubocop:enable Rails/Output
