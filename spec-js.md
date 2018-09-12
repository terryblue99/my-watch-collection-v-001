# Specifications for the Rails with jQuery Assessment  

Specs:  
- [x] Use jQuery for implementing new requirements  
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.  
       app/views/watches/show.html.erb  
       => show_links partial  
       => "Show Watch Details" link  
       => app/assets/javascripts/watches.js  
       => showWatch function.  
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.  
       app/views/watches/index.html.erb  
       => index_links partial  
       => show_watches partial  
       => 'Next' page link  
       => app/assets/javascripts/watches.js  
       => pagination function.  
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.  
       app/serializers/watch_serializer.rb => has_many :complications.  
       app/views/watches/show.html.erb  
       => show_links partial  
       => "show Complications" link  
       => app/assets/javascripts/complications.js
       => LoadComplications function
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.  
       app/views/watches/show.html.erb  
       => show_links partial  
       => "show Complications" link
       => select complication/s
       => "Update Watch" button  
       => app/assets/javascripts/complications.js
       => form#new_complication event handler
       => newComplication function
- [x] Translate JSON responses into js model objects.  
       => app/assets/javascripts/complications.js  
       => newComplication function  
       => Complication  
- [x] At least one of the js model objects must have at least one method added by your code to the prototype. 
       => app/assets/javascripts/complications.js  
       => newComplication function  
       => renderComplication function

Confirm  
- [x] You have a large number of small Git commits  
- [x] Your commit messages are meaningful  
- [x] You made the changes in a commit that relate to the commit message  
- [x] You don't include changes in a commit that aren't related to the commit message  