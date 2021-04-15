module UserHelper
    def avatar(user)
        if user.image.attached?
            image_tag(user.image.variant(resize_to_limit: [200, 200]))
        else
            image_tag('meeple.jpg')
        end
    end
end