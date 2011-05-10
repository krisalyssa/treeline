#!/usr/bin/env ruby -wKU

module Treeline
  class Parser
    
    def parse(lines)
      tree = {}
      @path = []
      
      lines.each do | line |
        # line.chomp!
        line.rstrip!
        line = yield(line) if block_given?
        
        # first, catch root elements (with no indent)
        if (line =~ /^\S/)
          @path = [ [ line, 0 ] ]
        else
          # next, catch indented elements
          matched = /^(\s+)/.match(line)
          unless (matched.nil?)
            indent = matched[1].length
            while (indent <= @path[0][1])
              @path.shift
            end
            line.lstrip!
            @path.unshift [ line, indent ]
          end
        end

        # puts self.to_s
        make_path_to_node(tree, @path.reverse)
        
      end
      
      tree
    end
  
  protected
  
    def make_path_to_node(tree, path)
      make_path_to_node(tree[path[0][0]], path[1..-1]) if (path.count > 1)
      tree[path[0][0]] = {} if (path.count == 1)
      tree
    end
    
  private
  
    def to_s
      @path.reverse.map { | item | item[0] }.join(" > ")
    end
    
  end
end
