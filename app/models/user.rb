class User < ActiveRecord::Base
    attr_accessor :password
    before_create :encrypt_password 

  	belongs_to :role
  	has_many :applications, dependent: :nullify
    has_many :terms, as: :termable
  	validates :first_name, presence: true 
	  validates :last_name, presence: true 
  	validates_presence_of :login_email
  	validates_uniqueness_of :login_email
    validates_presence_of :password

  	def encrypt_password
      unless password.blank?
      	self.password_salt = BCrypt::Engine.generate_salt
      	self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    	end
  	end

	   def authenticate(email, password)
    	 user = User.find_by(login_email: email)
    	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      #if user && user['login_password'] == password 
      		user
    	else
    	  	nil
    	end
  	end
end