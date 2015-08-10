class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  Parse.init :application_id => "djWG6FbqpN3oODfRTaaU7mDCBzHidJ18ORkTR88R",
             :api_key        => "E0YZCKzljiLB4mXsZntYN51KiuUzFoy24oUKr1f7"

end
