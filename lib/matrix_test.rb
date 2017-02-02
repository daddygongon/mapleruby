require './mapleruby'

a = 3
b = 3
c = [[1,4,7],[2,5,8],[3,6,9]]
d = [[1,0,0],[0,11,0],[0,0,1]]

x = RMaple.new.matrix(a, b, c)
y = RMaple.new.matrix(a, b, d)

p Mapleruby.new("convert(#{x},Matrix)+convert(#{y},Matrix)").exec_s
