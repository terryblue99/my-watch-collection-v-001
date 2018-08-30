class ApplicationController < ActionController::Base
  require "will_paginate/array"

  # An attacker may trick the users of a web application into executing actions of the attacker's choosing
  # Protect the app from this Cross-Site Request Forgery (CSRF) [ https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF) ]
  protect_from_forgery with: :exception

  before_action :authenticate_user!

end
