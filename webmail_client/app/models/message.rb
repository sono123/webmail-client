class Message < ActiveRecord::Base
  has_many :users

  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"
end
