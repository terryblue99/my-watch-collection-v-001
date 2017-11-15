class WatchesController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_watch, only: [:show, :edit, :update, :destroy]
	
	def index

		if user_signed_in?

			@user = User.find_user(current_user)

			if @user

			    @watches_for_display = @user.watches.size
			    session[:most_maker] = nil

			    # Selection made of how many watches to display on each page
			  	if session[:rows]
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:maker, :name)
			  	else
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
		# Initiated when user selects how many watches to display on each page

	  	if user_signed_in?
	  		
	  	  # Selection made of how many watches to display on each page	
	  	  if !session[:most_maker]

	      	session[:rows] = params[:rows]   
	      	redirect_to watches_path

	      else
	      	
	      	session[:maker_rows] = params[:rows]	   
	      	redirect_to most_maker_path

	      end	

	    else
	      redirect_to log_in_path, alert: "Please Log In to continue!"
	    end

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

		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end	

	end

	def create

		if user_signed_in?
			
			@watch = Watch.create_watch(watch_params)
			
			if @watch.errors.full_messages.size > 0
				session[:watch_errors] = @watch.errors.full_messages
		      	render :new
		    else
		   		current_user.watches << @watch
		   		params[:complications][:id].each do |complication|
		   			if !complication.empty?
		   				
		   				ComplicationsWatch.build_join(@watch, complication)

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

			begin
			  	
	          Watch.update_watch(@watch, watch_params)
	           
	        rescue => invalid_complication

	        	@watch.errors[:base] << "Invalid Complication: #{invalid_complication.message[65..-2]}"

	        end
			
			if @watch.errors.full_messages.size > 0
				session[:watch_errors] = @watch.errors.full_messages
		      	render :new
		    else    	
		    	params[:complications][:id].each do |complication|
		   			if !complication.empty?
		   				if !@watch.complications_watches.detect {|cw| cw.complication_id == complication.to_i}

			   				ComplicationsWatch.build_join(@watch, complication)

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
		      	Watch.delete_watch(@watch)
		      	redirect_to watches_path, notice: "'#{watch_name}' has been deleted!"
		    end

		else
			redirect_to log_in_path, alert: "Please Log In to continue!"
		end

	end

	def most_maker
		# Find the maker of most of the watches and display them

		if current_user.watches.size > 2 

			session[:most_maker] = "yes"

			most_maker_array = Watch.retrieve_most_maker(current_user)
			
			most_maker_array = most_maker_array.sort_by(&:name)
			@watches_for_display = most_maker_array.size

			# Selection made of how many watches to display on each page
		  	if session[:maker_rows] 
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		  	else
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => 15)
		  	end

		else

			@watches = current_user.watches.sort_by(&:name)
			@watches_for_display = current_user.watches.size

		end  	

	end


	private

	def set_watch

		@watch = Watch.find_watch(params[:id])

	end

	def watch_params

    # params hash keys
    params.require(:watch).permit(
    	:name,
    	:maker,
    	:movement,
    	:band,
    	:model_number,
    	:water_resistance,
    	:date_bought,
    	complication_attributes: [:name, :description]
    	)
  end

end