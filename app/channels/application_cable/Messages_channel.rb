class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conference_#{params[:id]}"
  end
end