# frozen_string_literal: true

print 'Seeding accounts'

20.times do
  FactoryBot.create(:account)
  print '.'
end

puts ''
