class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = I18n.t ".please_log_in"
      redirect_to login_url
    end
  end
end
