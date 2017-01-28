class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse
    component :mouse
  end

  def component(name)
    info = "get #{name}_info", @id
    p info
  end
end

obj = Computer.new(3,'tmp')
p obj.mouse

class MyClass
  define_method :my_method do |my_arg|
    my_arg *3
  end
end

obj = MyClass.new
p obj.my_method(2)
