
class ComplicationsController < ApplicationController
	before_action :set_session, only: [:show, :description]

	def show
		# Show the watch complication/s
		redirect_to watch_path(params[:watch_id])
		
	end

	def description
		# Show the description associated with a complication
		@comp_name = params[:comp_name]
		@comp_id = params[:comp_id]
		@watch_id = params[:watch_id]
		
		@description = ComplicationsWatch.description(@watch_id, @comp_id)
		
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
		# Activates the display of the watch complication/s
		session[:show_complications] = "yes"

	end


end