module Conferences
  class UsersController < ApplicationController
    before_action :load_conference, :check_access

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

    private
      def load_conference 
        @conference = Conference.find(params[:conference_id])
      end

      def check_access
        if not @conference.users.include?(current_user)
          redirect_to error_index_path, notice: 'access denied'
        end
      end
  end
end