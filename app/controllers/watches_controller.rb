class WatchesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_watch, only: [:show, :edit, :update, :destroy]

	def index

		if user_signed_in?

			@user = User.find_user(current_user)

			if @user

				session[:watches_on_page] ||= 16			
			    @watches_for_display = @user.watches.size
			    session[:find_maker] = nil
			    session[:most_maker] = nil
			    
			  	if session[:rows]
			  	# Selection made of how many watches to display on each page
			  		# selected by user
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:watch_maker, :watch_name)
			  	else
			  		# Default
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:watches_on_page]).order(:watch_maker, :watch_name)
			  	end

		    	respond_to do |format|
			      format.html { render 'index.html'}
			      format.json { render :json => @watches}
			      format.js
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

		session[:change_page_size?] = "yes"

	  	if user_signed_in?

	  	  if session[:find_maker]
	  	  	# Find a maker and their watches
	      	session[:maker_rows] = params[:rows]
	      	redirect_to find_maker_path
	  	  elsif session[:most_maker]
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
		    else
		    	respond_to do |format|
			      format.html { render 'show.html'}
			      format.json { render :json => @watch}
			      format.js
			    end
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
			binding.pry
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
			# watch_result will contain new complication record or complication validation error message/s
			watch_result = Watch.update_watch(@watch, watch_params)
			
			if watch_result[0] == "errors"
				@watch.errors[:base] << "Invalid Complication: #{watch_result[1]}"
			end

			if @watch.errors.full_messages.size > 0
				session[:watch_errors] = @watch.errors.full_messages
				watch_result = ""
	      		render :edit
		  	else
		  		
		  		@comp_names = []
		  		
		  		if params[:complications][:id].length > 1

			    	params[:complications][:id].each do |c_id|
						# selected from complication list on form
			   			if c_id.present?
			   				if !@watch.complications_watches.detect {|cw| cw.complication_id == c_id.to_i}
				   				ComplicationsWatch.build_join(@watch, c_id)		
								complication = Complication.find(c_id.to_i)
								@comp_names.push({id: complication.id, complication_name: complication.complication_name, watch_id: @watch.id})
					   		end
			   			end
		   			end

		   			if watch_result[0] == "new_complication"
		   				# new complication name and description entered on form
		   				@comp_names.push({id: watch_result[1].id, complication_name: watch_result[1].complication_name, watch_id: @watch.id})

		   			end

		   		else
		   		
		   			if watch_result[0] == "new_complication"
		   				# new complication name and description entered on form
		   				@comp_names.push({id: watch_result[1].id, complication_name: watch_result[1].complication_name, watch_id: @watch.id})
		   			end	

		   		end
	   			
	   			respond_to do |format|
			      format.html { redirect_to watch_path, notice: "The watch was successfully updated!"}
			      format.json { render :json => @comp_names}
			      format.js
			    end

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

	def search_watches
	# search for watch/watches matching search criteria
		
		if current_user.watches.size > 2
			
			session[:search_watches] = "yes"
			@watches = Watch.search_watches(current_user, params[:watch])
			@watches_for_display = @watches.size

		else

			@watches = current_user.watches
			@watches_for_display = current_user.watches.size

		end

	end

	def find_maker
	# Find a maker and all of their watches

		if params[:maker]
			session[:maker_param] = params[:maker]
		end	
		
		if current_user.watches.size > 2
			
			session[:find_maker] = "yes"
			find_maker_array = Watch.find_maker(current_user, session[:maker_param])
			@watches_for_display = find_maker_array.size
			# Selection made of how many watches to display on each page
		  	if session[:maker_rows]
		  		# selected by user
		    	@watches = find_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		  	else
		  		# Default
		    	@watches = find_maker_array.paginate(:page => params[:page], :per_page => session[:watches_on_page])
		  	end
		  	
		  	respond_to do |format|
		      format.html { render 'find_maker.html'}
		      format.json { render :json => @watches}
		      format.js
		    end

		else

			@watches = current_user.watches
			@watches_for_display = current_user.watches.size

		end

	end

	def most_maker
	# Find the maker of most of the watches and display them
		
		if current_user.watches.size > 2

			session[:most_maker] = "yes"
			session[:find_maker] = nil
			most_maker_array = Watch.retrieve_most_maker(current_user)
			@watches_for_display = most_maker_array.size
			# Selection made of how many watches to display on each page
		  	if session[:maker_rows]
		  		# selected by user
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		  	else
		  		# Default
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:watches_on_page])
		  	end
		  	
		  	respond_to do |format|
		      format.html { render 'most_maker.html'}
		      format.json { render :json => @watches}
		      format.js
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
    		:watch_image,
    		complications_attributes: [:complication_name, :complication_description]
    	)
  	end

end
