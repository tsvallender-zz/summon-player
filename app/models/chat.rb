class Chat < ApplicationRecord
  belongs_to :subject, polymorphic: true, optional: true
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages
  has_many :chat_users
  has_many :users, :through => :chat_users
end
