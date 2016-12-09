require './mapleruby'

p a = "matrix.txt"
p b = " "

data = RMaple.new.importmatrix("matrix.txt"," ")

RMaple.new.exportmatrix("ExportData.csv",data,",")

