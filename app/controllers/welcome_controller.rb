class WelcomeController < ApplicationController
  
  def index
  	@the_year = params[:the_year] ||= Time.now.year
  	@the_month = params[:this_month] ||= Time.now.month
  	@permagram = PermagramConnection.new(@the_month.to_i, @the_year.to_i)
  	@params = params
  	@years = [2015,1],[2016,2],[2017,3],[2018,4]
  	@months = [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],[9,9],[10,10],[11,11],[12,12]
  end
end
