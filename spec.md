# Specifications for the Rails Assessment  

Specs:  
- [x] Using Ruby on Rails for the project  
      True  
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)  
      User has_many :watches, User model line 8  
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)  
      Watch belongs_to User, Watch model line 5  
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
      Watch has_many Complications through Complications_watches, Watch model line 7  
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)  
      complications_watches.complication_description  
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)  
      Watch, Complication  
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)  
      Watch.retrieve_most_maker URL: /watches/most_maker  
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)  
      /watches/new, Complication  
- [x] Include signup (how e.g. Devise)  
      Devise  
- [x] Include login (how e.g. Devise)  
      Devise  
- [x] Include logout (how e.g. Devise)  
      Devise  
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)  
      Devise/OmniAuth, Facebook  
- [x] Include nested resource show or index (URL e.g. users/2/recipes)  
      watches/2/complications  
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)  
      watches/1/complications  
- [x] Include form display of validation errors (form URL e.g. /recipes/new)  
      /watches/new  

Confirm:  
- [x] The application is pretty DRY  
- [x] Limited logic in controllers  
- [x] Views use helper methods if appropriate  
- [x] Views use partials if appropriate  
