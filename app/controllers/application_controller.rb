class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html


  def after_sign_in_path_for(resource)
    #stored_location_for(resource) || welcome_path

  end

  def my_video

  end

end
