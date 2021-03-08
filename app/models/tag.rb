class Tag < ApplicationRecord
    validates :name,
      presence: true,
      length: { maximum: 15 }
      # need to check for allowed chars here too
    
    validates :description,
      length: { maximum: 1000 }
  
    has_many :ads, class_name: "AdTag", foreign_key: "ad_id"
  def to_param
    name
  end
end
