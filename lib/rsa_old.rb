require './mapleruby'

p1 = 3
q = 11
e = 3

n = p1 * q
l = RMaple.new.lcm(p1-1,q-1)

d = RMaple.new.mod(1/e,l)

code = RMaple.new.mod(3**e,n)
recode = RMaple.new.mod(code**d,n)

print("暗号文＝")
p code

print("復号文＝")
p recode
