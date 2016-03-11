class CommentsController < ApplicationController
	skip_before_action :authorize
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:name, :body))
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(@post) }
			format.json { head :no_content }
		end
	end

end
