class WatchesController < ApplicationController
	before_action :set_watch, only: [:show, :edit, :update, :destroy]
	
	def index
		if @user = User.find_by(email: current_user.email)
		    @watches_for_page_display = @user.watches.all
		  	if session[:rows] # Selection made of how many watches to display on each page
		    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:maker, :name)
		  	else # First time displaying watches
		    	@watches = @user.watches.paginate(:page => params[:page], :per_page => 15).order(:maker, :name)
		  	end
		else
			redirect_to log_in_path
		end
	end

	def rows
	  	binding.pry
	end

	def show
	    if !@watch   
	      redirect_to watches_path, alert: "The watch was not found!"
	    end
	end

	def new
		binding.pry
	end

	def create
		binding.pry
	end

	def update
		binding.pry
	end

	def destroy
		binding.pry
	end

	private

	def set_watch
		@watch = Watch.find_by_id(params[:id])
	end	

end