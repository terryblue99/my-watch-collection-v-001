# Application Design Plan

1. Seed data

    - Users  
    - Watches  
    - Complications  

2. Implement Devise/OmniAuth, using Facebook Sign In

    - Sign Up / Sign In / Sign Out  

3. Navbar

    - Header  
    - Flash Messages  

4. Create models and tables

    - user (Attributes: Devise attributes) => Action # 2  

        devise :database_authenticatable, :registerable,  
         :recoverable, :rememberable, :trackable, :validatable,  
         :omniauthable, :omniauth_providers => [:facebook]  

        has_many :watches  

        Method: @user.watches  

    - watch (Attributes: name, maker, movement, band, model_number, water_resistance, date_bought, user_id)  

         belongs_to :user  
         has_many :complications_watches  
         has_many :complications, through: :complications_watches  

         validates :name, presence: true  
         validates :maker, presence: true  

         Methods: @watch.user / @watch.complications   

    - complication (Attributes: name, description)  

       has_many :complications_watches  
       has_many :watches, through: :complications_watches  

       validates :name, presence: true  
       validates :name, uniqueness: true  
       validates :description, presence: true  

       Method: @complication.watches  

    - complications_watch (Attributes: watch_id, complication_id, complication_description)  

       belongs_to :watch  
       belongs_to :complication  

       (When trying to save a record in the join table -  
        it fails with "TypeError - nil is not a symbol nor a string"  
        because there is no "primary key".  
        The problem is solved by adding the following line to the model)  
        
       self.primary_key = 'watch_id'  

5. Create views

    - users (Devise) => Action # 2  
    - watches  
    - complications  

6. Create controllers

    - users (Devise) => Action # 2  
    - watches  
    - complications  

7. Code basic processing

    - Display all watches on successful Sign In  
    - Create a watch  
    - Show a watch  
    - Edit a watch  
    - Delete a watch  
    - Validation messages  
    - Flash messages  

8. Add complexities

    - Create a new watch with complication/s & join table description/s  
    - Delete a complication  
    - Show a complication's description  
    - Display the most maker and their watches  
    - Nested complication form with custom attribute writer in watch model  
    - Nested complication resource "show" form  
    - Nested complication resource "new" form  
    - Form display of validation errors  
