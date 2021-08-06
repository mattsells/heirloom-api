FactoryBot.define do
  factory :story do
    association :account

    trait(:with_image) do
      content_type { 'image' }
      image { Support::Attachments.image_data }
    end

    trait(:with_video) do
      content_type { 'video' }
      video { Support::Attachments.video_data }
    end
  end
end
