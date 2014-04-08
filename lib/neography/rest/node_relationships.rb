module Neography
  class Rest
    module NodeRelationships
      include Neography::Rest::Helpers

      def create_relationship(type, from, to, properties = nil)
        options = {
          :body => {
            :to => @connection.configuration + "/node/#{get_id(to)}",
            :data => properties,
            :type => type
          }.to_json,
          :headers => json_content_type }

        @connection.post("/node/%1$s/relationships" % [get_id(from)], options)
      end

      def get_node_relationships(id, direction = nil, types = nil)
        direction = parse_direction(direction)

        if types.nil?
          node_relationships = @connection.get("/node/%1$s/relationships/%2$s" % [get_id(id), direction]) || []
        else
          node_relationships = @connection.get("/node/%1$s/relationships/%2$s/%3$s" % [get_id(id), direction, encode(Array(types).join('&'))]) || []
        end

        return [] if node_relationships.empty?
        node_relationships
      end

    end
  end
end
