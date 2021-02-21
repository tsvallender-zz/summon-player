class Tag < ApplicationRecord
    validates :name,
      presence: true,
      length: { maximum: 15 }
      # need to check for allowed chars here too
    
    validates :description,
      length: { maximum: 1000 }
end
