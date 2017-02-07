class Machine < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(str)
    str.chars.each do |char|
      read(char)
    end
  end
end
