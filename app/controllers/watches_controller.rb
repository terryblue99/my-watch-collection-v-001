class WatchesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_watch, only: [:show, :edit, :update, :destroy]

	def index

		if user_signed_in?

			@user = User.find_user(current_user)

			if @user

			    @watches_for_display = @user.watches.size
			    session[:most_maker] = nil
			    # Selection made of how many watches to display on each page
			  	if session[:rows]
			  		# selected by user
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:watch_maker, :watch_name)
			  	else
			  		# Default
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => 18).order(:watch_maker, :watch_name)
			  	end

		    	respond_to do |format|
			      format.html { render 'index.html'}
			      format.json { render :json => @watches}
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

	  	  if session[:most_maker]
	  	  	# Maker of most of the watches and the watches
	      	session[:maker_rows] = params[:rows]
	      	redirect_to most_maker_path
	      else
	      	# All watches
	      	session[:rows] = params[:rows]
	      	redirect_to watches_path
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
						# collection complication
			   		if complication.present?
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
			# watch_result will contain complication validation error message/s, if any
			watch_result = Watch.update_watch(@watch, watch_params)

			if watch_result != nil
				@watch.errors[:base] << "Invalid Complication: #{watch_result}"
			end

			if @watch.errors.full_messages.size > 0
					session[:watch_errors] = @watch.errors.full_messages
					watch_result = nil
		      render :edit
		  else
		    	params[:complications][:id].each do |c_id|
						# collection complication
		   			if c_id.present?
		   				if !@watch.complications_watches.detect {|cw| cw.complication_id == c_id.to_i}
			   				ComplicationsWatch.build_join(@watch, c_id)
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

			if @watch
				watch_name = @watch.watch_name
	      Watch.delete_watch(@watch)
	      redirect_to watches_path, notice: "'#{watch_name}' has been deleted!"
	    else
	      redirect_to watches_path, alert: "The watch was not found!"
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
			@watches_for_display = most_maker_array.size
			# Selection made of how many watches to display on each page
		  	if session[:maker_rows]
		  		# selected by user
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		  	else
		  		# Default
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => 18)
		  	end

		else

			@watches = current_user.watches
			@watches_for_display = current_user.watches.size

		end

	end

	def newest_watches
  
    	session[:newest_watches] = "yes"
		@watches = Watch.retrieve_newest_watches(current_user)
		@watches_for_display = @watches.size

  	end

	private

	def set_watch
		@watch = Watch.find_watch(params[:id])
	end

	def watch_params
    # params hash keys
    params.require(:watch).permit(
    	:watch_name,
    	:watch_maker,
    	:movement,
    	:band,
    	:model_number,
    	:water_resistance,
    	:date_bought,
    	complications_attributes: [:complication_name, :complication_description]
    	)
  end

end
