class Ad < ApplicationRecord
  enum category: {rpg: 'rpg', ccg: 'ccg', boardgame: 'boardgame', 
    wargame: 'wargame', traditional: 'traditional', larp: 'larp'}
  validates :category, inclusion: { in: categories.keys }
  belongs_to :user
  validates :user_id, presence: true
  validates :text, presence: true, length: {maximum: 1000}
  has_many :tags, class_name: "AdTag", foreign_key: "tag_id"
end
