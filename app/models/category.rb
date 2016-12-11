class Category < ApplicationRecord
   extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
      name_changed?
    end

    def normalize_friendly_id(string)
      string.to_slug.normalize.to_s
    end
  has_many :posts

  validates :name, presence: true

  has_ancestry
end
