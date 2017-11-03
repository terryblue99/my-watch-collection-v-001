class WatchesController < ApplicationController
	before_action :set_watch, only: [:show, :edit, :update, :destroy]
	
	def index
		binding.pry
	end

	def rows
	  	binding.pry
	end

	def show
	    binding.pry
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