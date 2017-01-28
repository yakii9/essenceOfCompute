# 这里定义了一些大步语义相关的类

# 以下是一些基础的数据类型
class Num < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    self
  end
end

class Boolean < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    self
  end
end

class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    environment[name]
  end
end

# 以下是一些运算的定义
class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    Num.new(left.evaluate(environment)).value + Num.new(right.evaluate(environment)).value
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    Num.new(left.evaluate(environment)).value * Num.new(right.evaluate(environment)).value
  end
end

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def evaluate(environment)
    Boolean.new((left.evaluate(environment)).value < (right.evaluate(environment)).value)
  end
end

# 以下是一些表达式的定义
class DoNothing
  def to_s
    'do-nothing'
  end

  def inspect
    "<#{self}>"
  end

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def evaluate(environment)
    environment
  end
end

class Assign < Struct.new(:name, expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end
end

# 以下是序列的定义
class Sequence < Struct.new(:first, :others)
  def to_s
    "#{first}; #{others}"
  end

  def inspect
    "#<{self}>"
  end

  def evaluate(environment)
    others.evaluate(first.evaluate(environment))
  end
end

# 下面是循环语句的定义
class While < Struct.new(:condition, :body)
  def to_s
    "whie (#{condition}) { #{body} }"
  end

  def inspect
    "<#{self}>"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end
end
