class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :watches

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.find_user(current_user)
    self.find_by(email: current_user.email)   
  end


  def self.delete_user_watch_data(current_user)
    user = User.find_user(current_user)
    user.watches.each do |w|
      w.complications.delete_all
      w.destroy
    end
  end  

end
