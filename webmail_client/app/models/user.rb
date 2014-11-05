class User < ActiveRecord::Base
	has_many :messages

	def self.create_with_omniauth(auth)  
		create! do |user|  
			user.provider = auth["provider"]  
			user.uid = auth["uid"]  
			user.name = auth["info"]["name"]
			user.photo = auth["info"]["image"].gsub(/50/,"512")
			user.email = auth["info"]["email"]

		end  
	end 
end
