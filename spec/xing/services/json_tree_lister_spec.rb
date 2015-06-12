require 'xing/services/json_tree_lister'

describe Xing::Services::JsonTreeLister do

  # This simulates a node returned by an ActsAsNestedSet instance,
  # for purposes of JsonTreeLister, by simulating the is_ancestor_of?
  # behavior of that module.
  class FauxNode
    attr_accessor :path, :name, :parent
    def initialize(args)
      self.path = args[:path]
      self.name = args[:name]
      self.parent = args[:parent]
    end

    def is_ancestor_of?(other)
      if other.parent.blank?
        false
      elsif self == other.parent
        true
      else
        is_ancestor_of?(other.parent)
      end
    end
  end

  let (:a) { FauxNode.new(:path => "a", :name => "a") }
  let (:b) { FauxNode.new(:path => "b", :name => "b", :parent => a) }
  let (:c) { FauxNode.new(:path => "c", :name => "c", :parent => b) }
  let!(:d) { FauxNode.new(:path => "d", :name => "d", :parent => c) }
  let!(:e) { FauxNode.new(:path => "e", :name => "e", :parent => a) }
  let (:f) { FauxNode.new(:path => "f", :name => "f", :parent => a) }
  let!(:g) { FauxNode.new(:path => "g", :name => "g", :parent => f) }
  let!(:h) { FauxNode.new(:path => "h", :name => "h", :parent => f) }

  let :expected_tree do
    {
      name: "a",
      url: "a",
      children: [
        {
          name: "b",
          url: "b",
          children: [
             {
               name: "c",
               url: "c",
               children: [
                  {
                    name: "d",
                    url: "d",
                    children: []
                  }
               ]
             }
          ]
        },
        {
          name: "e",
          url: "e",
          children: []
        },
        {
          name: "f",
          url: "f",
          children: [
            {
              name: "g",
              url: "g",
              children: []
            },
            {
              name: "h",
              url: "h",
              children: []
            }
          ]
        }
      ]
    }
  end

  class SimpleNodeSerializer
    def initialize(tree_node)
      @tree_node = tree_node
    end

    attr_reader :tree_node

    def as_json
      {
        :name => tree_node.node.name,
        :url => tree_node.node.path,
        :children => tree_node.children
      }
    end
  end

  it "should produce a correct tree for a node with no childen" do
    expect(d).to receive(:self_and_descendants).and_return([d])
    expect(Xing::Services::JsonTreeLister.new(d.self_and_descendants, SimpleNodeSerializer).render).to eq({name: "d", url: "d", children: []})
  end

  it "should produce a correct tree for a parent of a big tree" do
    expect(a).to receive(:self_and_descendants).and_return([a, b, c, d, e, f, g, h])
    expect(Xing::Services::JsonTreeLister.new(a.self_and_descendants, SimpleNodeSerializer).render).to eq(expected_tree)
  end

end
