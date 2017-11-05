class WatchesController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_watch, only: [:show, :edit, :update, :destroy]
	
	def index
		if user_signed_in?
			if @user = User.find_by(email: current_user.email)
			    @watches_for_page_display = @user.watches.all
			  	if session[:rows] # Selection made of how many watches to display on each page
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:maker, :name)
			  	else # First time displaying watches
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => 15).order(:maker, :name)
			  	end
			else
				redirect_to log_in_path, alert: "Please Log In to continue!"
			end
		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end	
	end

	def rows
	  	binding.pry
	end

	def show
		if user_signed_in?
		    if !@watch   
		      	redirect_to watches_path, alert: "The watch was not found!"
		    end
		else
			redirect_to log_in_path, alert: "Please Log In to continue!" 
		end	  
	end

	def new
		if user_signed_in?
			@watch = Watch.new
			@all_complications = Complication.all
			@watch_complications = @watch.complications_watches.build
		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end	
	end

	def create
		if user_signed_in?
			@watch = Watch.create(watch_params)
			if @watch.errors.full_messages.size > 0
				session[:watch_errors] = @watch.errors.full_messages
		      	redirect_to new_watch_path
		    else
		   		current_user.watches << @watch
		   		params[:complications][:id].each do |complication|
		   			if !complication.empty?
		   				@watch.complications_watches.build(complication_id: complication).save
		   			end	
		   		end	
		      	redirect_to watch_path(@watch), notice: "The watch was successfully saved!"
			end
		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end	
	end

	def update
		if user_signed_in?
			@watch.update(watch_params)
			if @watch.errors.full_messages.size > 0
				session[:watch_errors] = @watch.errors.full_messages
		      	redirect_to edit_watch_path
		    else
		    	params[:complications][:id].each do |complication|
		   			if !complication.empty?
		   				if !@watch.complications_watches.detect {|cw| cw.complication_id == complication.to_i}
				   				@watch.complications_watches.build(complication_id: complication).save
				   				@cw = ComplicationsWatch.last
				   				@cw.complication_description = Complication.find_by(id: complication).description
				   				@cw.save
				   		end		
		   			end
		   		end
		     	redirect_to watch_path, notice: "The watch was successfully edited!"
		    end
		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end
	end

	def destroy
		if user_signed_in?
			if !@watch   
		      	redirect_to watches_path, alert: "The watch was not found!"
		    else
		      	watch_name = @watch.name	
		      	@watch.delete
		      	redirect_to watches_path, notice: "'#{watch_name}' has been deleted!"
		    end
		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end
	end

	private

	def set_watch
		@watch = Watch.find_by_id(params[:id])
	end

	def watch_params
    # modify method to accept the params hash keys
    params.require(:watch).permit(
    	:name,
    	:maker,
    	:movement,
    	:band,
    	:model_number,
    	:water_resistance,
    	:date_bought
    	)
  end

end