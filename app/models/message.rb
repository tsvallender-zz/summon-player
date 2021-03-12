class Message < ApplicationRecord
    belongs_to :from, class_name: "User"
    belongs_to :to, class_name: "User"
    belongs_to :ad, optional: true

    validates :text, presence: true, length: {maximum: 500} 
    
  def to_param
    from.name
  end
end
