require 'active_model_serializers'
require 'active_support/core_ext'

module Xing
  module Services
    class JsonTreeLister

      class TreeNode
        include ActiveModel::SerializerSupport

        def initialize(node, children)
          @node = node
          @children = children
        end

        attr_reader :node, :children
      end

      def initialize(nodes, node_serializer)
        @nodes = nodes
        @node_serializer = node_serializer
        @stack = [[]]
        @path = []
      end

      def render_node(node, children)
        @node_serializer.new(TreeNode.new(node, children)).as_json
      end

      def pop_level
        children = @stack.pop
        @stack.last << render_node(@path.pop, children)
      end

      def render
        (@nodes + [nil]).each_cons(2) do |this, after|
          until @path.empty? or @path.last.is_ancestor_of?(this)
            pop_level
          end
          if after.nil? or !this.is_ancestor_of?(after)
            @stack.last << render_node(this, [])
          else
            @path << this
            @stack << []
          end
        end
        until @path.empty?
          pop_level
        end
        return @stack.last.first
      end


    end
  end
end
