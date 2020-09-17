module RoomsHelper

	#最新メッセージのデータを取得して表示
	def most_new_message_preview(room)
		message = room.messages.order(updated_at: :desc).limit(1)
		message = message[0]
		if message.present?
			tag.p "#{message.body}", class: "dmlist_content_linkbox_message"
		else
			tag.p "{　まだメッセージはありません}", class: "dmlist_content_linkbox_message"
		end
	end

	# 相手ユーザー名を取得して表示
	def opponent_user(room)
		entry = room.entries.where.not(user_id: current_user)
		name = entry[0].user.name
		tag.p "#{name}", class: "dmlist_content_linkbox_name"
	end
end