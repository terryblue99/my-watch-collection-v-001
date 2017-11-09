class WatchesController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_watch, only: [:show, :edit, :update, :destroy]
	
	def index

		if user_signed_in?

			if @user = User.find_by(email: current_user.email)
			    @watches_for_display = @user.watches.size
			    session[:most_maker] = nil
			    # Selection made of how many watches to display on each page
			  	if session[:rows]
			    	@watches = @user.watches.paginate(:page => params[:page], :per_page => session[:rows]).order(:maker, :name)
			    	session[:rows] = nil
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

	  	if user_signed_in?

	  	  # Selection made of how many watches to display on each page	
	  	  if !session[:most_maker]
	      	session[:rows] = params[:rows]   
	      	redirect_to watches_path
	      else
	      	session[:maker_rows] = params[:rows]
	      	session[:most_maker] = nil
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
		   				@cw = ComplicationsWatch.last
		   				@cw.complication_description = Complication.find_by(id: complication).description
		   				@cw.save
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

	def most_maker

		if current_user.watches.size > 2 

			session[:most_maker] = "yes"
			most_maker = current_user.watches.group(:maker).order('count_all DESC').limit(1).count
			most_maker_array = current_user.watches.select { |w| w.maker == most_maker.keys[0] }
			@watches_for_display = most_maker_array.size
			most_maker_array = most_maker_array.sort_by(&:name)

		  	if session[:maker_rows] # Selection made of how many watches to display on each page
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		    	session[:maker_rows] = nil
		  	else # First time displaying watches
		    	@watches = most_maker_array.paginate(:page => params[:page], :per_page => 15)
		  	end

		else

			@watches = current_user.watches.sort_by(&:name)
			@watches_for_display = @watches.size
			@watches = @watches.paginate(:page => params[:page], :per_page => 15)

		end  	

	end	

	def watch_complications
		
		session[:show_complications] = "yes"
		redirect_to watch_path
		
	end	


	private

	def set_watch

		@watch = Watch.find_by_id(params[:id])

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