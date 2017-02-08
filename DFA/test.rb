require './machine.rb'
require './rule.rb'

rules = [
  FARule.new(1, 'a', 2),
  FARule.new(2, 'b', 3),
  FARule.new(3, 'c', 1)
]

book = RuleBook.new(rules)

machine = Machine.new(1, [1, 2, 3], book)
puts machine.accepting?
machine.read_string('abc')
puts machine.accepting?
