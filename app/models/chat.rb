class Chat < ApplicationRecord
  belongs_to :subject, polymorphic: true, optional: true
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages
  has_many :chat_users, dependent: :destroy
  has_many :users, :through => :chat_users

  def self.with_users(users)
    Chat.joins(:users)
        .where(users: { id: users })
        .group(:id)
        .having(User.arel_table[Arel.star].count.eq(users.length))
        .first
  end
end
