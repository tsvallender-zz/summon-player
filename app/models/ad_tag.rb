class AdTag < ApplicationRecord
    belongs_to :ad, class_name: 'Ad'
    belongs_to :tag, class_name: 'Tag'
    validates :ad_id, presence: true
    validates :tag_id, presence: true
end
