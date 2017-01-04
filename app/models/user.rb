class User < ApplicationRecord
	validates_presence_of :name, :password
	has_secure_password
	has_many :posts

	def self.authenticate(name, password)
		 @user = User.find_by_name(name)
		 if !@user.nil?
		 	if @user.authenticate(password)
		 		return @user
		 	end
		 end

		 return nil
	end
end
