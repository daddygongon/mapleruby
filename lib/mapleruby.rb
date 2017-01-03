require "mapleruby/version"
require 'systemu'
require 'yaml'

class RMaple
  #整数論
  def nextprime(a)
    a = a.to_i
    p Mapleruby.new("nextprime(#{a})").exec_i
  end
  def isprime(a)
    a = a.to_i
    p Mapleruby.new("isprime(#{a})").exec_b
  end
  def lcm(a,b)
    a = a.to_i
    b = b.to_i
    p Mapleruby.new("lcm(#{a},#{b})").exec_i
  end
  def gcd(a,b)
    a = a.to_i
    b = b.to_i
    p Mapleruby.new("gcd(#{a},#{b})").exec_i
  end
  def rand(a)
    a = a.to_i
    p Mapleruby.new("rand(#{a})()").exec_i
  end
  def mod(a,b)
    a = a.to_i
    b = b.to_i
    p Mapleruby.new("modp(#{a},#{b})").exec_i
  end
  def ifactor(a)
    a = a.to_i
    print(Mapleruby.new("ifactor(#{a})").exec_s)
  end

  #行列
  def matrix(a,b,c)
    p a.to_i
    p b.to_i
    p c
    puts text = "with(LinearAlgebra): matrix(#{a}, #{b}, #{c})"
    p x = Mapleruby.new(text).exec_matrix(b)
  end
  def importmatrix(a,b)
    p a
    p b
    text = "ImportMatrix(\"#{a}\",delimiter=\"#{b}\")"
    p Mapleruby.new(text).exec_i
  end
=begin
  def exportmatrix(a,b,c)
    p a
    p b
    p c
    puts text = "ExportMatrix(\"#{a}\",b,delimiter=\"#{c}\")"
    p Mapleruby.new(text).exec_s
  end
=end
  def matrixinverse(a)
    p a
    puts text = "with(LinearAlgebra): a:=convert(#{a},Matrix): MatrixInverse(a)"
    p Mapleruby.new(text).exec_s
  end
  def determinant(a)
    p a
    puts text = "with(LinearAlgebra): a:=convert(#{a},Matrix): Determinant(a)"
    p Mapleruby.new(text).exec_i
  end
  def transpose(a)
    p a
    puts text = "with(LinearAlgebra): a:=convert(#{a},Matrix): Transpose(a)"
    p Mapleruby.new(text).exec_s
  end
  def eigenvectors(a)
    p a
    puts text = "with(LinearAlgebra): a:=convert(#{a},Matrix): Eigenvectors(a)"
   # puts text = "with(LinearAlgebra): a:=convert(#{a},Matrix): evalf(Eigenvectors(a))"
    p Mapleruby.new(text).exec_s
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
  def exec_i
    result = exec
    return result.to_i
  end
  def exec_b
    result = exec
    return false if result.match(/false/)
    return true if result.match(/true/)
  end
 def exec_s
    result = exec
    return result
 end
 def exec_matrix(b)
   x = exec.gsub(/[^\d]/, " ")
   x1 = x.split(" ").map(&:to_i)
   result = x1.each_slice(b).to_a
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





