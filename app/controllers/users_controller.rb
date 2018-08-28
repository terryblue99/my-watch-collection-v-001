class UsersController < ApplicationController

	def delete_user

		User.delete_user_watch_data(current_user)
		deleted_user = current_user.email
		current_user.destroy

		redirect_to new_user_session_path, alert: "Bye #{deleted_user}! Your account has been successfully cancelled. We hope to see you again soon."

	end	

end
