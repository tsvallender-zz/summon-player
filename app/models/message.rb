class Message < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  belongs_to :chat

  validates :text, presence: true, length: {maximum: 500} 
  validates :from, presence: true
  validates :to, presence: true
  
  def to_param
    from.name
  end
end
