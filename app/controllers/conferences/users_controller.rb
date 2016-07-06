module Conferences
  class UsersController < ApplicationController
    before_action :load_conference, only: [:index, :add_user_in_conference]

    def index
      @users = @conference.users
    end

    def show_all_users
      @users = User.all
    end


    def add_user_in_conference
      @user = User.find(params[:user_id])
      @conference << @user
      redirect_to conference_users_path @conference
    end

    def load_conference 
      @conference = Conference.find(params[:conference_id])
    end
  end
end