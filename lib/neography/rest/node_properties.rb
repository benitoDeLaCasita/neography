module Neography
  class Rest
    module NodeProperties

      def set_node_properties(id, properties)
        properties.each do |property, value|
          options = { :body => value.to_json, :headers => json_content_type }
          @connection.put("/node/%1$s/properties/%2$s" % [get_id(id), property], options)
        end
      end

      def reset_node_properties(id, properties)
        options = { :body => properties.to_json, :headers => json_content_type }
        @connection.put("/node/%1$s/properties" % [get_id(id)], options)
      end

      def get_node_properties(id, *properties)
        if properties.none?
          @connection.get("/node/%1$s/properties" % [get_id(id)])
        else
          get_each_node_properties(id, *properties)
        end
      end

      def get_each_node_properties(id, *properties)
        retrieved_properties = properties.flatten.inject({}) do |memo, property|
          value = @connection.get("/node/%1$s/properties/%2$s" % [get_id(id), property])
          memo[property] = value unless value.nil?
          memo
        end
        return nil if retrieved_properties.empty?
        retrieved_properties
      end

      def remove_node_properties(id, *properties)
        if properties.none?
          @connection.delete("/node/%1$s/properties" % [get_id(id)])
        else
          remove_each_node_properties(id, *properties)
        end
      end

      def remove_each_node_properties(id, *properties)
        properties.flatten.each do |property|
          @connection.delete("/node/%1$s/properties/%2$s" % [get_id(id), property])
        end
      end


    end
  end
end
