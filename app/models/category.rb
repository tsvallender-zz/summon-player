class Category < ApplicationRecord
    has_many :ads

    def to_param
        stub
    end
end
