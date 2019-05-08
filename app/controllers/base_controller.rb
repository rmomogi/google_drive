class BaseController < ApplicationController
  before_action :authenticate_user!, :expired_token?
  layout 'user_session'

  private

  def expired_token?
    sign_out current_user unless current_user.persisted?
  end

end
