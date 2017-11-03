# Application Design Plan 

1. Seed data

    - Watch Complications  

2. Implement Devise/OmniAuth, using Facebook Sign In

    - Sign Up / Sign In / Sign Out  

3. Navbar

    - Header  
    - Flash Messages  

4. Create models and tables

    - user (Devise attributes) => Action # 2  

        devise :database_authenticatable, :registerable,  
         :recoverable, :rememberable, :trackable, :validatable,  
         :omniauthable, :omniauth_providers => [:facebook]  

        has_many :watches 
        belongs_to :current_watch, class_name: "Watch"  

        Method: @user.watches  

    - watch (name, maker, movement, band, model_number, water_resistance, date_bought, user_id)  

         belongs_to :user  
         has_many :watches_complications  
         has_many :complications, through: :watches_complications  

         validates :name, presence: true  
         validates :maker, presence: true  

         Methods: @watch.user / @watch.complications   

    complication (name)  

       has_many :watches_complications  
       has_many :watches, through: :watches_complications  

       validates :name, presence: true  

       Method: @complication.watches  

    watches_complications (watch_id, complication_id, complication_quantity)  

       belongs_to :watch  
       belongs_to :complication  

5. Create views

    users (Devise) => Action # 2  
    watches  

6. Create controllers

    users (Devise) => Action # 2  
    watches  
    complications  

7. Code basic processing

    Display all watches on successful Sign In  
    Create a watch  
    Show a watch  
    Edit a watch  
    Delete a watch  
    flash messages  

8. Add complexities

    Create a new watch with complications (with quantity)  
    Diplay the most maker and watches  
    Nested form with custom attribute in associated model  
    Nested resource show or index (URL e.g. users/2/recipes)  
    Nested resource "new" form (URL e.g. recipes/1/ingredients)  
    Form display of validation errors (form URL e.g. /recipes/new)  



