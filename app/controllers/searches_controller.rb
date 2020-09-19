class SearchesController < ApplicationController

	def find
		@range = params[:range]
		find = params[:find]
		word = params[:word]

		if @range == '1'
			@user = User.word_find(find,word)
		elsif @range == '2'
			@post = Post.word_find(find,word)
		else 
			@topic = Topic.word_find(find,word)
		end
	end
end
