class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery with: :exception
  before_action :authenticate_user!

end
