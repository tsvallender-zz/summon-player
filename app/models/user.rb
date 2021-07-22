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
  has_many :groups, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :memberships, :through => :group_users, :source => :group
  has_many :posts, dependent: :destroy
  
  has_many :ad_users, dependent: :destroy
  has_many :followed_ads, :source => :ad_users, :through => :ad
  
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
