# frozen_string_literal: true

print 'Seeding users'

2.times do
  FactoryBot.create(:user)
  print '.'
end

Account.all.find_each do |account|
  2.times do
    user = FactoryBot.create(:user)
    AccountUser.create(account: account, user: user, role: 'standard')
    print '.'
  end

  user = FactoryBot.create(:user)
  AccountUser.create(account: account, user: user, role: 'admin')
  print '.'
end

puts ''
