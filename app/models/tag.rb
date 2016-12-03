class Tag < ApplicationRecord
   
  extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
      name_changed?
    end

    def normalize_friendly_id(string)
      string.to_slug.normalize.to_s
    end

  has_many :taggings
  has_many :posts, through: :taggings

  def self.counts
    self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end
end
