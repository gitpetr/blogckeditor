class Post < ApplicationRecord
  extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
      title_changed?
    end

    def normalize_friendly_id(string)
      string.to_slug.normalize.to_s
    end
  mount_uploader :image, ImageUploader
  validates :title, :body, presence: true
end
