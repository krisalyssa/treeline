#!/usr/bin/env ruby -wKU

require "test/unit"
require File.expand_path('lib/treeline/parser')

class ParserTest < Test::Unit::TestCase

  def test_parser
    lines = []
    lines << "A"
    lines << "  A::B1"
    lines << "  A::B2"
    lines << "    A::B2::C"
    lines << "  A::B3"
    lines << "    A::B3::D1"
    lines << "    A::B3::D2"
    
    parser = Treeline::Parser.new

    tree = parser.parse lines
    assert_not_nil tree
    assert_equal 1, tree.keys.count
    assert_has_key tree, 'A'
    
    subtree = tree['A']
    assert_not_nil subtree
    assert_equal 3, subtree.keys.count
    assert_has_key subtree, 'A::B1'
    assert_has_key subtree, 'A::B2'
    assert_has_key subtree, 'A::B3'
    
    subsubtree = subtree['A::B1']
    assert_not_nil subsubtree
    assert_equal 0, subsubtree.keys.count
    
    subsubtree = subtree['A::B2']
    assert_not_nil subsubtree
    assert_equal 1, subsubtree.keys.count
    assert_has_key subsubtree, 'A::B2::C'
    
    subsubtree = subtree['A::B3']
    assert_not_nil subsubtree
    assert_equal 2, subsubtree.keys.count
    assert_has_key subsubtree, 'A::B3::D1'
    assert_has_key subsubtree, 'A::B3::D2'
  end
  
  def test_parser_with_block
    lines = []
    lines << "A"
    lines << "  A::B1"
    lines << "  A::B2"
    lines << "    A::B2::C"
    lines << "  A::B3"
    lines << "    A::B3::D1"
    lines << "    A::B3::D2"
    
    parser = Treeline::Parser.new
    
    tree = parser.parse(lines) do | item |
      item.downcase
    end
    assert_not_nil tree
    assert_equal 1, tree.keys.count
    assert_has_key tree, 'a'
    
    subtree = tree['a']
    assert_not_nil subtree
    assert_equal 3, subtree.keys.count
    assert_has_key subtree, 'a::b1'
    assert_has_key subtree, 'a::b2'
    assert_has_key subtree, 'a::b3'
    
    subsubtree = subtree['a::b1']
    assert_not_nil subsubtree
    assert_equal 0, subsubtree.keys.count
    
    subsubtree = subtree['a::b2']
    assert_not_nil subsubtree
    assert_equal 1, subsubtree.keys.count
    assert_has_key subsubtree, 'a::b2::c'
    
    subsubtree = subtree['a::b3']
    assert_not_nil subsubtree
    assert_equal 2, subsubtree.keys.count
    assert_has_key subsubtree, 'a::b3::d1'
    assert_has_key subsubtree, 'a::b3::d2'
    
  end

protected

  def assert_has_key(tree, key, msg=nil)
    msg = "Key '#{key}' not found" if msg.nil?
    flunk msg unless tree.has_key?(key)
  end
  
end
