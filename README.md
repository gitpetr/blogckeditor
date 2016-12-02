//  rails new blogpost -T
// cd  blogpost

# см gemfile

$ bundle
$ rails generate friendly_id
$ rails g   scaffold Post  title:string body:text image  category_id:integer:index slug:string:uniq

app/models/post.rb
  class Post < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
      title_changed?
    end

    def normalize_friendly_id(string)
      string.to_slug.normalize.to_s
    end
end

post_controller.rb
 # добавляем friendly, убираем slug
 .....
    def set_post
      @post = Post.friendly.find(params[:id])
    end

   def post_params
      params.require(:post).permit(:title, :body)
    end
$  rake db:migrate

$ rails s
 # если нет ошибок то можно создать пост, дать имя на русском языке,  slug оставить пустым, в строке адреса будет не id поста, а его название.

 # index.html.slim
 = render @posts
= link_to 'New Post', new_post_path

#_post.html.slim
article.post
  section.post-head
    h2= link_to post.title, post 
    small
      time='  post.created_at.to_date.strftime("%d %B, %Y")
      ' | 
      =' link_to 'Изменить', edit_post_path(post)
      ' | 
      = link_to 'Удалить', post, method: :delete, data: { confirm: "Удалить насовсем?"}
  section.post-summary.clearfix
    = image_tag(post.image_url(:thumb), class: 'img-thumbnail thumb' ) if post.image?
    = strip_tags(raw(post.body).truncate(580))

# show.html.slim
article.post
  section.post-head
    h1= @post.title 
    small
      time='  @post.created_at.to_date.strftime("%d %B, %Y")
      ' | 
      =' link_to 'Изменить', edit_post_path(@post)
      ' | 
      = link_to 'Удалить', @post, method: :delete, data: { confirm: "Удалить насовсем?"}
  section.post-body.clearfix
    = image_tag(@post.image_url(:thumb), class: 'img-thumbnail thumb' ) if @post.image?
    = raw(@post.body.html_safe)


# config/application.rb
    config.time_zone = 'Asia/Omsk'
    config.i18n.default_locale = :ru
