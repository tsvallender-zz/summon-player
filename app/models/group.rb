class Group < ApplicationRecord
  belongs_to :user
  has_many :group_users, dependent: :destroy
  has_many :members, :through => :group_users, :source => :user
  has_many :posts, as: :subject

  enum privacy: { open: 'open', request: 'request', invite: 'invite' }
  validates :privacy, inclusion: { in: privacies.keys}

  validates :name, presence: true
end
