# frozen_string_literal: true

namespace :test do
  desc 'Open the coverage report'
  task coverage: :environment do
    `open coverage/index.html`
  end
end
