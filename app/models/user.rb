class User < ApplicationRecord
  # Not using :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :ads, dependent: :destroy
  
  has_many :chat_users
  has_many :chats, :through => :chat_users
  has_many :messages
  has_one_attached :image, dependent: :destroy
  
  validates :username,
    presence:   true,
    length:     { maximum: 20 },
    format:     { with: /\A[\w_-]+\z/i }

  validates :description,
  	length:			{ maximum: 1000 }

  validates :dob,
    presence:   true,
    timeliness: {on_or_before: 16.years.ago}
    
  def to_param
    username
  end

  def unread_chats
    unread = 0
    chat_users.each do |cu|
      if cu.last_read < cu.chat.updated_at
        unread += 1
      end
    end
    unread
  end
end
