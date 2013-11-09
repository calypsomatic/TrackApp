class Goal < ActiveRecord::Base
	belongs_to :user, inverse_of: :goals


end
