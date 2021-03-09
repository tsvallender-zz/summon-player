class Ad < ApplicationRecord
  enum category: {rpg: 'rpg', ccg: 'ccg', boardgame: 'boardgame', 
    wargame: 'wargame', traditional: 'traditional', larp: 'larp'}
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :text, presence: true, length: { maximum: 1000 }
  validates :category, inclusion: { in: categories.keys }

  has_many :adtags, class_name: "AdTag", foreign_key: "ad_id"
  has_many :tags, through: :adtags, :source => :tag
end
