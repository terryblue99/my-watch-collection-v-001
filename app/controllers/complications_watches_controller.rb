class ComplicationsWatchesController < ApplicationController

	def create

		if !current_user.current_watch
			current_user.current_watch = current_user.watches.create
			current_user.save
		end

		comp = current_user.current_watch.add_complication(params[:complication_id])
		comp.save
		session[:comps_in_watch] += 1
		
		redirect_to watch_path(current_user.current_watch)
		
	end

end
