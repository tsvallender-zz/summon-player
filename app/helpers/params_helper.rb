module ParamsHelper
    def parse_participants(param)
        participants = Array.new
        if param.respond_to? :each
          param.each do |p|
            participants << User.find(p.to_i)
          end
        else
          participants << User.find(param.to_i)
        end
        participants << current_user
    end
end