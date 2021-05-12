class Ad < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :text, presence: true, length: { maximum: 1000 }

  has_many :adtags, class_name: "AdTag", foreign_key: "ad_id"
  has_many :tags, through: :adtags, :source => :tag

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :desc, -> { order(created_at: :desc) }

  def addTags(tags)
    if self.tags.count + tags.length > 10
      raise "ads cannot have more than 10 tags"
    end

    tags.each do |t|
      # check tag exists, if not create it
      tag = nil
      unless tag = Tag.find_by(name: t)
        tag = Tag.create(name: t)
      end
      AdTag.create(ad_id: self.id, tag_id: tag.id)
    end
  end

  def interested
    user_ids = Message.where(ad_id: id).where.not(from: user).distinct.pluck(:from_id)
    users = []
    user_ids.each do |u|
      users.append(User.find(u))
    end
    users
  end

end
