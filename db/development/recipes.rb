# frozen_string_literal: true

print 'Seeding recipes'

Account.all.find_each do |account|
  50.times do
    FactoryBot.create(:recipe, :with_cover_image, :with_directions, :with_ingredients, account: account)
    print '.'
  end
end

puts ''
