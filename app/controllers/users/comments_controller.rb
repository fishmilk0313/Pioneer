class Users::CommentsController < ApplicationController
	def create
		post_comment = Post.find(params[:post_id])
		comment = current_user.comment.new(post_comment_params)
		comment.post_id = post_id
		comment.save
		redirect_to users_post_path(post)

	end

	def destroy
		Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
		redirect_to users_post_path(params[:post_id])
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end