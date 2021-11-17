class User < ActiveRecord::Base
  has_secure_password

  validates :email,                 presence: true, uniqueness: { case_sensitive: false }
  validates :password,              presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :first_name,            presence: true
  validates :last_name,             presence: true

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip) 
    if @user
      if @user.authenticate(password)
        return @user
      end
    end
  end
end