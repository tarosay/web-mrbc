class ApplicationController < ActionController::Base
  protect_from_forgery
  self.allow_forgery_protection = false
end
