class Contact < ApplicationRecord
	validates :email,
	 		  :presence => {:message => "が空欄です" }

	validates :name,
	 		  :presence => {:message => "が空欄です" },
	 		  :length => { :maximum => 10, :message => "は10文字以内です。"}
	 
	validates :content, 
			  :presence => {:message => "が空欄です" },
	 		  :length => { :maximum => 50, :message => "は50文字以内です。"}
end
