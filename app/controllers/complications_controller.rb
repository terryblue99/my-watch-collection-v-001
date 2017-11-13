
class ComplicationsController < ApplicationController
	before_action :set_session

	def show
		
		redirect_to watch_path(params[:watch_id])
		
	end

	def description

		@comp_name = params[:comp_name]
		@description = ComplicationsWatch.find_by(watch_id: params[:watch_id], complication_id: params[:comp_id]).complication_description
		@comp_id = params[:comp_id]
		
	end

	def complication_errors(errors)
		binding.pry
		session[:watch_errors] = errors
		redirect_to edit_watch_path

	end	

	def destroy
		
		# Delete the complications_watches join record
		if user_signed_in?

			@watch = Watch.find_by_id(params[:watch_id])

			if !@watch   
		      	redirect_to description_path(params[:watch_id]), alert: "The watch was not found!"
		    else	
		      	@watch.complications.delete(params[:comp_id])
		      	redirect_to watch_path(params[:watch_id]), notice: "Complication: '#{params[:comp_name]}' has been deleted!"
		    end

		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end
		
	end

	def set_session

		session[:show_complications] = "yes"

	end


end