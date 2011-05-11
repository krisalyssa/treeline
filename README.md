# Treeline

Treeline turns indented-line input into a tree structure.

Given a sequence of lines with varying levels of indentation, like this:

    line 1
      line 2
      line 3
        line 4
      line 5
      
Treeline will produce a hash like this:

    {
      "line 1" => {
        "line 2" => {},
        "line 3" => {
          "line 4" => {},
        },
        "line 5" => {},
      },
    }

## Installation

    $ gem install treeline

## Usage

The `parse` method on `Treeline::Parser` does the heavy lifting.

    parser = Treeline::Parser.new
    tree = parser.parse lines
    
The parser is bone-headed simple. The first line of input is taken to be the root of a new tree.
For each subsequent line, the amount of indentation is compared to the amount in the previous line, and

* if the indentation is the same, the new line is added as a sibling of the previous;
* if the indentation is greater, the new line is added as a child of the previous; or
* if the indentation is less, the parser climbs back towards the root until one of the previous
  two rules applies.

`parse` optionally takes a block. Each line of the input will be passed to the block, which should
return the line modified as desired. For instance, to force all of the text to lowercase:

    parser = Treeline::Parser.new
    tree = parser.parse(lines) do | line |
      line.downcase
    end
    
The block is called *before* the amount of indentation is determined, so you can change the indentation
if you want to.
    
## Dependencies

None at the moment.

## Support

Wiki: <https://github.com/CraigCottingham/treeline/wiki>

## Contributing

Treeline has been written the particular need I have *right now* in mind. I'm trying hard not to bulk it up
with stuff that I or someone else might want someday. That being said, if you have a particular need that
Treeline doesn't quite satisfy in its current state, I'm happy to consider requests or (better yet)
contributions.

Here’s the most direct way to get your work merged into the project:

1. Fork the project.
2. Clone down your fork ( git clone git://github.com/<username>/treeline.git ).
3. Create a topic branch to contain your change ( git checkout -b my_awesome_feature ).
4. Hack away, add tests. Not necessarily in that order.
5. Make sure everything still passes by running `rake test`.
6. If necessary, rebase your commits into logical chunks, without errors.
7. Push the branch up ( git push origin my_awesome_feature ).
8. Send a pull request.

## License

Copyright &copy; 2011 Craig S. Cottingham.
It is free software, and may be redistributed under the terms specified in the LICENSE file.