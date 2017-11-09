
class ComplicationsController < ApplicationController


	def show
		
		session[:show_complications] = "yes"
		redirect_to watch_path(params[:watch_id])
		
	end

	def description

		session[:show_complications] = "yes"
		@description = ComplicationsWatch.find_by(watch_id: params[:id]).complication_description
		
	end


end