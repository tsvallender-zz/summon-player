class ChatsUsers < ApplicationRecord
    belongs_to :chat, class_name: 'Chat'
    belongs_to :user, class_name: 'User'
    validates :ad_id, presence: true
    validates :tag_id, presence: true
end
