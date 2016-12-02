json.extract! post, :id, :title, :body, :image, :category_id, :slug, :created_at, :updated_at
json.url post_url(post, format: :json)