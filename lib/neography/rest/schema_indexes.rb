module Neography
  class Rest
    module SchemaIndexes
      include Neography::Rest::Helpers

      def get_schema_index(label)
        @connection.get("/schema/index/%1$s" % [label])
      end

      def delete_schema_index(label, index)
        @connection.delete("/schema/index/%1$s/%2$s" % [label, index])
      end

      def create_schema_index(label, keys = [])
        options = {
          :body => (
            { :property_keys => keys
            }
          ).to_json,
          :headers => json_content_type
        }
        @connection.post("/schema/index/%1$s" % [label], options)
      end
    end
  end
end
