class FARule < Struct.new(:state, :character, :next_state)
  def apply_to?(state, character)
    self.state == state && self.character == character
  end

  def follow
    next_state
  end

  def inspect
    "FARule #{state} -- #{character}"
  end
end

class RuleBook < Struct.new(:rules)
  def next_state(state, character)
    return 'STOP' if rule_for(state, character).nil?
    rule_for(state, character)
  end

  def rule_for(state, character)
    rules.detect { |rule| rule.apply_to?(state, character) }
  end
end
