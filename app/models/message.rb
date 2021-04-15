class Message < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :chat, touch: true

  validates :text, presence: true, length: {maximum: 500} 
  validates :from, presence: true
  
  def to_param
    from.name
  end
end
