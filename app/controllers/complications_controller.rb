
class ComplicationsController < ApplicationController
	before_action :set_session

	def show
		
		redirect_to watch_path(params[:watch_id])
		
	end

	def description
		
		@comp_name = params[:comp_name]
		@description = Complication.description(params[:comp_id])
		
	end

	def set_session

		session[:show_complications] = "yes"

	end


end