class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    puts "after_sign_in_path_for called"
    if resource_or_scope.is_a?(User)
      user_path(resource_or_scope)
    else
      root_path
    end
    # current_user
  end
end
