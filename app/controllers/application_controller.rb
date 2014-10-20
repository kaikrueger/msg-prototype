class ApplicationController < ActionController::Base

  before_action :set_locale

  protect_from_forgery with: :null_session,
                       if: Proc.new { |c| c.request.format =~ %r{application/json} }

  include SessionsHelper

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_header || I18n.default_locale
  end

  private

  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end