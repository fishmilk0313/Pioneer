class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def index
    @rooms = current_user.rooms
  end

  def show
    @rooms = current_user.rooms
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to request.referer
  end
end
