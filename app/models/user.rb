class User < ActiveRecord::Base

  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  EMAIL_REGEX = /\A[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\z/
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: EMAIL_REGEX }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  has_many :posts

  def self.authenticate(username_or_email, login_password)
  	if EMAIL_REGEX.match(username_or_email)
  		user = User.find_by_email(username_or_email)
  	else
  		user = User.find_by_username(username_or_email)
  	end

  	if user && user.match_password(login_password)
  		return user
  	else
  		return false
  	end
  end

  def encrypt_password
  	unless password.blank?
  		self.salt = BCrypt::Engine.generate_salt
  		self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  	end
  end

  def match_password(login_password)
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end



  def clear_password
  	self.password = nil
  end
end
