class WatchesController < ApplicationController
	
	before_action :set_watch, only: [:show, :edit, :update, :destroy]

	def index

		# Set watches per page default if not already set
		session[:watches_on_page] ||= 16

	    @watches_for_display = current_user.watches.size
	    session[:search_watches] = nil
		session[:find_maker] = nil
		session[:most_maker] = nil
		session[:newest_watches] = nil

	    if session[:rows]
	  	# Selection made of how many watches to display on each page
	  		# selected by user
	    	@watches = current_user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:watch_maker, :watch_name)
	  	else
	  		# Default
	    	@watches = current_user.watches.paginate(:page => params[:page], :per_page => session[:watches_on_page]).order(:watch_maker, :watch_name)
	  	end
	  	
    	respond_to do |format|
	      format.html { render 'index.html'}
	      format.json { render :json => @watches}
	      format.js
	    end

	end

	def rows
	# Initiated when user selects how many watches to display on each page
		
	  	session[:page_size_changed?] = "yes"

	  	session[:rows] = params[:rows]

	  	 if session[:search_watches]
	  	  # Find watches
	      redirect_to search_watches_path
	  	 elsif session[:find_maker]
	  	  # Find a maker and their watches
	      redirect_to find_maker_path
	  	 elsif session[:most_maker]
	  	  # Maker of most of the watches and the watches
	      redirect_to most_maker_path
	     else
	      # All watches
	      redirect_to watches_path
	     end
	end

	def show

	    if !@watch
	      	redirect_to watches_path, alert: "The watch was not found!"
	    else
	    	respond_to do |format|
		      format.html { render 'show.html'}
		      format.json { render :json => @watch}
		      format.js
		    end
	    end
	end

	def new
		@watch = Watch.new
	end

	def create

		@watch = Watch.create_watch(watch_params)

		if @watch.errors.full_messages.size > 0
			session[:watch_errors] = @watch.errors.full_messages
	      	render :new
	  	else
	   		current_user.watches << @watch
	   		params[:complications][:id].each do |complication|
			   	if complication.present?
			   		ComplicationsWatch.build_join(@watch, complication)
			   	end
		  	end
	    	redirect_to watch_path(@watch), notice: "The watch was successfully saved!"
		end
	end

	def update
		
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
		   					# build the complications_watches join record if one doesn't already exist
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
	end

	def destroy

		if @watch
			watch_name = @watch.watch_name
	      	Watch.delete_watch(@watch)
	      	redirect_to watches_path, notice: "'#{watch_name}' has been deleted!"
	    else
	      	redirect_to watches_path, alert: "The watch was not found!"
	    end
	end

	def search_watches
	# search for watch/watches matching search criteria
		
		if params[:watch]
			session[:watch_param] = params[:watch]
		end
			
		session[:search_watches] = "yes"
		session[:find_maker] = nil
		session[:most_maker] = nil
		session[:newest_watches] = nil
		search_watches_array = Watch.search_watches(current_user, session[:watch_param])
		@watches_for_display = search_watches_array.size
	    @watches_array = search_watches_array
	    paginate

	    respond_to do |format|
	      format.html { render 'search_watches.html'}
	      format.json { render :json => @watches}
	      format.js
	    end

	end

	def find_maker
	# Find a maker and all of their watches

		if params[:maker]
			session[:maker_param] = params[:maker]
		end	
			
		# Set number of watches displayed on each page 
		session[:find_maker] = "yes"
		session[:search_watches] = nil
		session[:most_maker] = nil
		session[:newest_watches] = nil
		find_maker_array = Watch.find_maker(current_user, session[:maker_param])
		@watches_for_display = find_maker_array.size
	    @watches_array = find_maker_array
	    paginate
	  	
	  	respond_to do |format|
	      format.html { render 'find_maker.html'}
	      format.json { render :json => @watches}
	      format.js
	    end

	end

	def most_maker
	# Find the maker of most of the watches and display them
		
		if current_user.watches.size > 2

			# Set number of watches displayed on each page
			session[:most_maker] = "yes"
			session[:search_watches] = nil
			session[:find_maker] = nil
			session[:newest_watches] = nil
			most_maker_array = Watch.retrieve_most_maker(current_user)
			@watches_for_display = most_maker_array.size
		    @watches_array = most_maker_array
		    paginate
		  	
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
    	session[:search_watches] = nil
    	session[:find_maker] = nil
    	session[:most_maker] = nil
		@watches = Watch.retrieve_newest_watches(current_user)
		@watches_for_display = @watches.size

  	end

	private

	def set_watch
		@watch = Watch.find_watch(params[:id])
	end

	def watch_params
    	# params hash keys (strong params)
    	params.require(:watch).permit(
    		:watch_name,
    		:watch_maker,
    		:movement,
    		:band,
    		:model_number,
    		:water_resistance,
    		:date_bought,
    		:cost,
    		:case_measurement,
    		:watch_image,
    		complications_attributes: [:complication_name, :complication_description]
    	)
  	end

  	def paginate
  		
  		if session[:rows]
	  	# Selection made of how many watches to display on each page
	  		# selected by user
	    	@watches = @watches_array.paginate(:page => params[:page], :per_page => session[:rows])
	  	else
	  		# Default
	    	@watches = @watches_array.paginate(:page => params[:page], :per_page => session[:watches_on_page])
	  	end

  	end	

end
