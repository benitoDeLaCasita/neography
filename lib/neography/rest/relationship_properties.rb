module Neography
  class Rest
    module RelationshipProperties

      def set_relationship_properties(id, properties)
        properties.each do |property, value|
          options = { :body => value.to_json, :headers => json_content_type }
          @connection.put("/relationship/%1$s/properties/%2$s" % [get_id(id), property], options)
        end
      end

      def reset_relationship_properties(id, properties)
        options = { :body => properties.to_json, :headers => json_content_type }
        @connection.put("/relationship/%1$s/properties" % [get_id(id)], options)
      end

      def get_relationship_properties(id, *properties)
        if properties.none?
          @connection.get("/relationship/%1$s/properties" % [get_id(id)])
        else
          get_each_relationship_properties(id, *properties)
        end
      end

      def get_each_relationship_properties(id, *properties)
        retrieved_properties = properties.flatten.inject({}) do |memo, property|
          value = @connection.get("/relationship/%1$s/properties/%2$s" % [get_id(id), property])
          memo[property] = value unless value.nil?
          memo
        end
        return nil if retrieved_properties.empty?
        retrieved_properties
      end

      def remove_relationship_properties(id, *properties)
        if properties.none?
          @connection.delete("/relationship/%1$s/properties" % [get_id(id)])
        else
          remove_each_relationship_properties(id, *properties)
        end
      end

      def remove_each_relationship_properties(id, *properties)
        properties.flatten.each do |property|
          @connection.delete("/relationship/%1$s/properties/%2$s" % [get_id(id), property])
        end
      end


    end
  end
end
