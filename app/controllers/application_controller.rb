class ApplicationController < ActionController::Base
  # FIXME still broken
  # Logs user out, won't add to nursery
  # protect_from_forgery

  def after_sign_in_path_for(resource)
    user_lists_path(current_user.id)
  end
end
