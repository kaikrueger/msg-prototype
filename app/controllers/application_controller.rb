class ApplicationController < ActionController::Base

  before_action :set_locale

  protect_from_forgery with: :null_session,
                       if: Proc.new { |c| c.request.format =~ %r{application/json} }

  include SessionsHelper

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end
end