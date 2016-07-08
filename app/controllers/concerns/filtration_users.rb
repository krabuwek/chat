module FiltrationUsers
  extend ActiveSupport::Concern

  included do
    before_action :load_conference, :check_access
  end

  def load_conference 
    @conference = Conference.find(params[:conference_id])
  end

  def check_access
    unless @conference.users.include?(current_user)
      redirect_to error_index_path, notice: 'access denied'
    end
  end
end