class ChatsUsers < ApplicationRecord
    belongs_to :chat, class_name: 'Chat'
    belongs_to :user, class_name: 'User'
end
