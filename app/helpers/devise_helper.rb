module DeviseHelper

	def devise_error_messages!
		
	  return "" if resource.errors.empty?

	  messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
	  sentence = I18n.t("errors.messages.not_saved",
	                    count: resource.errors.count,
	                    resource: resource.class.model_name.human.downcase)

	  html = <<-HTML
		<div class="row">  
		  	<div class="col-sm-8 col-sm-offset-2">  
			  	<div class="alert alert-danger">
				  	
					  <div id="error_explanation">
					    <h2>#{sentence}</h2>
					    <ul>#{messages}</ul>
					  </div>
					
				</div>
			</div>
		</div>  
	  HTML

	  html.html_safe
	end

end