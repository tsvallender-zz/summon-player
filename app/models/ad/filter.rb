class Ad::Filter
    def filter(scope, query_params)
        if query_params[:terms].present?
            puts "HERE WE ARE" + query_params[:terms]
            scope = scope.where("title ILIKE :terms OR text ILIKE :terms",
                terms: "%#{query_params[:terms]}%")
        end
        
        if query_params[:category_id].present?
            scope = scope.where(category_id: query_params[:category_id])
        end

        scope
    end
end