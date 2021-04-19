module ChatHelper
    def other_users(chat)
        chat.users.where.not(id: current_user.id)
    end
end