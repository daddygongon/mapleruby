require 'mapleruby'

p a = 1.0e10
RMaple.new.nextprime(a)
RMaple.new.isprime(a)

p a = 5
RMaple.new.rand(a)


p x = 15
p y = 64
RMaple.new.lcm(x,y)
RMaple.new.gcd(x,y)

p x = 7
p y = 3
RMaple.new.mod(x,y)

p a = 42
RMaple.new.ifactor(a)
