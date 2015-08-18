class WelcomeController < ApplicationController
  require 'permagramconnection'
  def index
  	params[:this_month] = 7
  	@permagram = PermagramConnection.new(params[:this_month])
  	@params = params
  end
end
