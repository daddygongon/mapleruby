require './mapleruby'
=begin
p a = "matrix.txt"
p b = " "

data = RMaple.new.importmatrix("matrix.txt"," ")

RMaple.new.exportmatrix("ExportData.csv",data,",")
=end

a = 3
b = 3
c = [[1,4,7],[2,5,8],[3,6,9]]
d = [[1,0,0],[0,11,0],[0,0,1]]

p x = RMaple.new.matrix(a, b, c)
#p y = RMaple.new.matrix(a, b, d)

#p Mapleruby.new("convert(#{x},Matrix)+convert(#{y},Matrix)").exec_s


#RMaple.new.matrixinverse(x)
#RMaple.new.determinant(y)
#RMaple.new.transpose(x)
RMaple.new.eigenvectors(x)
