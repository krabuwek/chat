class ConferenceUsersController < ApplicationController
  before_action :load_conference, only: [:index]

  def index
    @users = @conference.users
  end

  def load_conference 
    @conference = Conference.find(params[:conference_id])
  end
end
