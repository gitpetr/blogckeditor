class Post < ApplicationRecord
  extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
      title_changed?
    end

    def normalize_friendly_id(string)
      string.to_slug.normalize.to_s
    end
  has_many :taggings
  has_many :tags, through: :taggings
  mount_uploader :image, ImageUploader
  validates :title, :body, presence: true

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
