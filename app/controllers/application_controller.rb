class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home, :index, :show], unless: :skip_pundit?
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  after_action :verify_authorized, except: [:index, :dashboard, :conversations], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :address, :bio, :photo ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :bio, :photo ])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
