class Message < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :chat

  validates :text, presence: true, length: {maximum: 500} 
  validates :from, presence: true

  after_save :touch_chat
  
  def to_param
    from.name
  end

  # Keep chat updated_at time correct with new messages
  def touch_chat
    chat.touch
  end
end
