module Neography
  class Rest
    module NodeLabels
      include Neography::Rest::Helpers

      def list_labels
        @connection.get("/labels")
      end

      def get_node_labels(id)
        @connection.get("/node/%1$s/labels"  % [get_id(id)])
      end

      def get_nodes_labeled(label)
        @connection.get("/label/%1$s/nodes" % [label])
      end

      def find_nodes_labeled(label, hash)
        @connection.get("/label/%1$s/nodes?%2$s=%3$s"  % [label, hash.keys.first, escape(hash.values.first)])
      end

      def add_label(id, label)
        options = {
          :body => (
            label
          ).to_json,
          :headers => json_content_type
        }
        @connection.post("/node/%1$s/labels"  % [get_id(id)], options)
      end

      def set_label(id, label)
        options = {
          :body => (
            Array(label)
          ).to_json,
          :headers => json_content_type
        }
        @connection.put("/node/%1$s/labels"  % [get_id(id)], options)
      end

      def delete_label(id, label)
        @connection.delete("/node/%1$s/labels/%2$s" % [get_id(id), label])
      end


    end
  end
end
