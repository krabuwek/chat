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
      redirect_to conference_users_path @conference
    end

    def destroy
      @user = User.find(params[:user_id])
      @conference.users.delete(@user)
      redirect_to conference_users_path @conference
    end
  end
end