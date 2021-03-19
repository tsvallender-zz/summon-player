class Chat < ApplicationRecord
  belongs_to :subject, polymorphic: true
  has_many :messages
end
