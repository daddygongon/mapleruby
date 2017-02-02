require "mapleruby/version"
require 'systemu'
require 'yaml'

class RMaple
  #行列
  def matrix(a,b,c)
    p a.to_i
    p b.to_i
    p c
    puts text = "with(LinearAlgebra): matrix(#{a}, #{b}, #{c})"
    p x = Mapleruby.new(text).exec_m(b)
  end
end

class Mapleruby
  DATA_FILE=File.join(ENV['HOME'],'.mapleruby_rc')
  # Your code goes here...
  def initialize(maple_code)
    @maple_code = maple_code
    @src = get_env
    @maple_path=@src[:MAPLE_PATH]
  end
  def exec_m(b)
     x = exec.gsub(/[^\d]/, " ") #本来
     x1 = x.split(" ").map(&:to_i)
     result = x1.each_slice(b).to_a
    # x = exec.split("").map(&:to_i) #要素に0があった場合不可
    # x1 = x.delete_if{|i| i==0}
    # result = x1.each_slice(b).to_a
    # x = exec.split("") #要素に二桁以上の値があった場合不可
    # x1 = x.delete_if{|i| i == " "}
    # x2 = x1.delete_if{|j| j == "\n"}
    # x3 = x2.delete_if{|k| k == "]"}
    # x4 = x3.delete_if{|l| l =="["}
    # x5 = x4.map(&:to_i)
    # result = x5.each_slice(b).to_a
    return result
  end
   def exec
    code0=<<EOS
interface(quiet=true);
writeto("./result.txt");
#{@maple_code};
writeto(terminal);
interface(quiet=false);
EOS
    File.write('tmp.mw',code0)
    command="#{@maple_path} tmp.mw"
    status,stdout,stderr=systemu command
    status,stdout,stderr=systemu 'cat result.txt'
   # result=stdout
   # print(result)
    return stdout
  end

  def get_env
    begin 
      file = File.open(DATA_FILE,'r')
    rescue => evar
      p evar
      print "no resource file for mapleruby.\n"
    end
    @src = YAML.load(file.read)
    file.close
    p @src
  end

end
