class ComplicationsController < ApplicationController

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

		@watch = Watch.find_watch(params[:watch_id])

		if !@watch
		    redirect_to description_path(params[:watch_id]), alert: "The watch was not found!"
	    else
	    
	    	Watch.delete_join(@watch, params[:comp_id])

	    	if !params[:comp_name]
	    		# appended name being deleted and name not in params
	    		comp_name = Complication.find_by_id(params[:comp_id]).complication_name
	    	else
	    		comp_name = params[:comp_name]
	    	end

	    	session[:display_complications] = "yes"
	      	redirect_to watch_path(params[:watch_id]), notice: "Complication: '#{comp_name}' has been deleted from the watch!"
	    end
	end

	def delete_list_comp
		# Delete a complication from the complications list
		# Will also delete ALL related complications_watches join records 
		comp = Complication.find_by_id(params[:comp_id])
		comp_name = comp.complication_name
		comp.destroy
		session[:display_complications] = "yes"
		redirect_to watch_path(params[:id]), notice: "Complication: '#{comp_name}' has been deleted from the list!"
	end

end



