require 'treetop'
Treetop.load('simple')
parse_tree = SimpleParser.new.parse('while (x < 5) {x = x*3}')
