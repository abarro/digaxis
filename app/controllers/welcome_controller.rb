class WelcomeController < ApplicationController
  require 'permagramconnection'
  def index
  	@permagram = PermagramConnection.new
  	@params = params
  end
end
