# frozen_string_literal: true

print 'Seeding stories'

def random_story_type
  Story.story_types.keys.sample
end

def random_content_type
  rand(2) ? :with_image : :with_video
end

Recipe.all.find_each do |recipe|
  8.times do
    story = FactoryBot.create(:story, random_content_type, account: recipe.account, story_type: random_story_type)
    RecipeStory.create(recipe: recipe, story: story)
    print '.'
  end
end

puts ''
