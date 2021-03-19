class Chat < ApplicationRecord
  belongs_to :subject, polymorphic: true, optional: true
  has_many :messages
  accepts_nested_attributes_for :messages
  has_and_belongs_to_many :chats_users
  has_and_belongs_to_many :users, :through => :chats_users
end
