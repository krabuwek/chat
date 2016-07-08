module Conferences
  class UsersController < ApplicationController
    before_action :load_conference

    def index
      @users = @conference.users
    end

    def new
      @users = User.all
    end

    def create
      @user = User.find(params[:user_id])
      @conference.users << @user
      redirect_to conference_users_path @conference
    end

    def destroy
      @user = User.find(params[:user_id])
      @conference.users.delete(@user) = users
      @conference.save
      redirect_to conference_users_path @conference
    end

    private
      def load_conference 
        @conference = Conference.find(params[:conference_id])
      end
  end
end