class ComplicationsController < ApplicationController
	before_action :set_session, only: [:show, :description]

	def show
	# Show the watch complication/s
		redirect_to watch_path(params[:watch_id])
	end

	def description
	# Get the description associated with a complication

		@comp_name = params[:comp_name]
		@comp_id = params[:comp_id]
		@watch_id = params[:watch_id]
		@description = ComplicationsWatch.description(@watch_id, @comp_id)

	end

	def destroy
	# Delete the complications_watches join record

		if user_signed_in?

			@watch = Watch.find_watch(params[:watch_id])

			if !@watch
		    redirect_to description_path(params[:watch_id]), alert: "The watch was not found!"
	    else
	    	Watch.delete_join(@watch, params[:comp_id])
	    	session[:display_complications] = "yes"
	      	redirect_to watch_path(params[:watch_id]), notice: "Complication: '#{params[:comp_name]}' has been deleted!"
	    end

		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end

	end

	def set_session
	# Activate the display of the watch complication/s
		session[:show_complications] = "yes"
	end

end
