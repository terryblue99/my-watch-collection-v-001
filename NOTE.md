# Application Design Plan 

1. Seed data

    - Watch Complications  

2. Implement Devise/OmniAuth, using Facebook Sign In

    - Sign Up / Sign In / Sign Out  

3. Navbar

    - Header  
    - Flash Messages  

4. Crearte models and tables

    - user (Devise attributes) => Action # 2  

        has_many :watches  

        Method: @user.watches

    - watch (watch_name, maker, model_number, date_bought, user_id, movement_id, water_resistance)  

         belongs_to :user  
         has_many :watches_complications  
         has_many :complications, through: watches_complications  

         validates :watchname, presence: true  
         validates :maker, presence: true  

         Methods: @watch.user / @watch.complications   

    complication (:name)  

       has_many :watches_complications  
       has_many :watches, through: :watches_complications  

       validates :name, presence: true  

       Method: @complication.watches

5. Create views

    users (Devise) => Action # 2  
    watches  

6. Create controllers

    users (Devise) => Action # 2  
    watches  

7. Code basic processing

    Display all watches on successful Sign In  
    Create a watch  
    Show a watch  
    Delete a watch  
    flash messages  

 8. Add complexities
 