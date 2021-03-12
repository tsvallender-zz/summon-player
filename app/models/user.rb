class User < ApplicationRecord
  # Not using :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :ads, dependent: :destroy
  has_many :sent_messages, foreign_key: :from_id, class_name: "Message"
  has_many :received_messages, foreign_key: :to_id, class_name: "Message"
         
  validates :username,
    presence:   true,
    length:     { maximum: 20 },
    format:     { with: /\A[\w_-]+\z/i }

  validates :description,
  	length:			{ maximum: 1000 }

  def to_param
    name
  end

  # Returns a list of user ids this user is conversing with
  def conversations
    (sent_messages.distinct.pluck(:to_id) + received_messages.distinct.pluck(:from_id)).uniq
  end

  # Returns the conversation with a given user
  def conversation(user_id)
    sent_messages.where(to_id: user_id).or(received_messages.where(from_id: user_id)).order("created_at")
  end
end
