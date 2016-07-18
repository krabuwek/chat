module Conferences
  class UsersController < ApplicationController
    include FiltrationUsers

    def index
      @users = @conference.users
    end

    def new
      @users = User.all
    end

    def create
      @user = User.find(params[:user_id])
      if @conference.users.include?(@user)
        redirect_to conference_users_path @conference, notice: 'user #{@user.email} was in conference'
      end  
      @conference.users << @user
      ActionCable.server.broadcast "conference_#{@conference.id}",
        message: "user #{current_user.email} added user #{@user.email} in conference",
        username: "chat"
      redirect_to conference_users_path @conference
    end

    def destroy
      @user = User.find(params[:user_id])
      @conference.users.delete(@user)
      ActionCable.server.broadcast "conference_#{@conference.id}",
        message: "user #{current_user.email} deleted user:#{@user.email} of conference",
        username: "chat"
      redirect_to conference_users_path @conference
    end
  end
end