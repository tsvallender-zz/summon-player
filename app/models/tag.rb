class Tag < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 15 }
    # need to check for allowed chars here too
  
  validates :description,
    length: { maximum: 1000 }

  has_many :adtags, class_name: "AdTag", foreign_key: "tag_id"
  has_many :ads, through: :adtags, :source => :ad

  has_many :tagusers, class_name: "TagUser", foreign_key: "tag_id", dependent: :destroy
  has_many :followers, :through => :tagusers, :source => :user
  
  def to_param
    name
  end
end
