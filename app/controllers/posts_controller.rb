class PostsController < ApplicationController
	before_action :authorize, only: [:create, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :destroy, :update]

  def index
  	@posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def new
  	@post = Post.new
  end

  def destroy
  	@post.destroy
  	respond_to do |format|
  		format.html { redirect_to posts_url }
  		format.json { head :no_content }
  	end
  end

  def create
  	@post = Post.new(post_params)

  	respond_to do |format|
  		if @post.save
  			format.html { redirect_to @post }
  			format.json { render :show, status: :created, location: @post }
  		else
  			format.html { render :new}
  			format.json { render json: @post.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def update
    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render 'edit'
    end
  end


  def show
  end

  def edit
  end


  private

  def find_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :body)
  end

end