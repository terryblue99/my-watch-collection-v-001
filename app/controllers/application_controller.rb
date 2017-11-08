class ApplicationController < ActionController::Base
  require 'will_paginate/array'	
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
