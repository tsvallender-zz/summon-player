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
end
