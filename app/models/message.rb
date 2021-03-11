class Message < ApplicationRecord
    belongs_to :from, class_name: "User"
    belongs_to :to, class_name: "User"

    validates :text, presence: true, length: {maximum: 500} 
end
