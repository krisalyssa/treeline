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
    
  end
  
end
