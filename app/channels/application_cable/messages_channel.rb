class MessagesChannel < ApplicationCable::Channel
  def subscribed
    #conference = Conference.find(params[:conference_id])
    conference = "conference_#{params[:id]}"
    stream_from conference
  end
end