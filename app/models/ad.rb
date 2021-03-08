class Ad < ApplicationRecord
  enum category: {rpg: 'rpg', ccg: 'ccg', boardgame: 'boardgame', 
    wargame: 'wargame', traditional: 'traditional', larp: 'larp'}
  belongs_to :user

  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :category, inclusion: { in: categories.keys }

  has_many :tags, class_name: "AdTag", foreign_key: "tag_id"
end
