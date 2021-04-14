class User < ApplicationRecord
  # Not using :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :ads, dependent: :destroy
  
  has_many :chat_users
  has_many :chats, :through => :chat_users
         
  validates :username,
    presence:   true,
    length:     { maximum: 20 },
    format:     { with: /\A[\w_-]+\z/i }

  validates :description,
  	length:			{ maximum: 1000 }

  def to_param
    username
  end

  def conversation_with(user)
    self.chats.u users.include? user
  end
end
