class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      redirect_to(user_posts_path(current_user), success: '投稿に成功しました')
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body) #パラメーターのキー
  end
end
