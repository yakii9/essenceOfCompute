require './Basic.rb'

environment = {:x => Num.new(1)}

environment.each { |a, b| puts "#{a} = #{b.value}" }

Machine.new(
  Sequence.new(
    If.new(
      LessThan.new(Variable.new(:x), Num.new(72)),
      Assign.new(
        :y,
        Add.new(
          Multiply.new(Num.new(2), Num.new(4)),
          Multiply.new(Num.new(3), Num.new(6))
        )
      ),
      Assign.new(
        :y,
        Add.new(
          Multiply.new(Num.new(16), Num.new(4)),
          Multiply.new(Num.new(7), Num.new(6))
        )
      )
    ),
    Assign.new(
      :y,
      Add.new(
        Multiply.new(Num.new(16), Num.new(4)),
        Multiply.new(Num.new(7), Num.new(6))
      )
    )
  ), environment
).run

Machine.new(
  While.new(
    LessThan.new(Variable.new(:x), Num.new(56)),
    Assign.new(:x, Add.new(Variable.new(:x), Num.new(3)))
  ), environment
).run
