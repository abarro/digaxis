class WelcomeController < ApplicationController
  require 'permagramconnection'
  def index
  	params[:this_month] = Time.now.month
  	@permagram = PermagramConnection.new(params[:this_month])
  	@params = params
  end
end
