module Conferences
  class UsersController < ApplicationController
    before_action :load_conference, only: [:index, :destroy]

    def index
      @users = @conference.users
    end

    def create
      @user = User.find(params[:user_id])
      @conference << @user
      redirect_to conference_users_path @conference
    end

    def destroy
      @user = User.find(params[:user_id])
      users = @conference.users
      users.delete(@user);
      @conference.users = users
      @conference.save
      redirect_to conference_users_path @conference
    end

    private
      def load_conference 
        @conference = Conference.find(params[:conference_id])
      end
  end
end