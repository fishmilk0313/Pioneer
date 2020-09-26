class SearchesController < ApplicationController

	def find
		@range = params[:range]
		find = params[:find]
		word = params[:word]

		if @range == '1'
			@user = User.word_find(find,word)
		elsif @range == '2'
			@post = Post.word_find(find,word)
		elsif @range == '3'
			@topic = Topic.word_find(find,word)
		else
			redirect_to request.referer
		end
	end
end
