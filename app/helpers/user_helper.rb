module UserHelper
    def avatar(user, size)
        if user.image.attached?
            image_tag(user.image.variant(resize_to_limit: [size, size]))
        else
            image_tag('meeple.jpg', size: size.to_s)
        end
    end
end