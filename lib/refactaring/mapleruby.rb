require "mapleruby/version"
require 'systemu'
require 'yaml'

class RMaple
  def nextprime(a)
    main_i :nextprime, a
  end
  def rand(a)
    main_i :rand, a
  end
  def lcm(a,b)
    main_i :lcm, a, b
  end
  def gcd(a,b)
    main_i :gcd, a, b
  end
  def mod(a,b)
    main_i :modp, a, b
  end
  def main_i(name,*list_a)
    p name
    p list_a
    p Mapleruby.new("#{name}",list_a).exec_i
  end
  def isprime(a)
    main_b :isprime, a
  end
  def main_b(name,*list_a)
    p name
    p list_a
    p Mapleruby.new("#{name}",list_a).exec_b
  end
  def ifactor(a)
    main_s :ifactor, a
  end
  def main_s(name,*list_a)
    p name
    p list_a
    print(Mapleruby.new("#{name}",*list_a).exec_s)
  end
  def matrix(a,b,c)
    p a.to_i
    p b.to_i
    p c
    puts text = "with(LinearAlgebra): matrix(#{a}, #{b}, #{c})"
    p x = Mapleruby.new(text).exec_m(b)
  end
  def importmatrix(a,b)
    p a
    p b
    text = "ImportMatrix(\"#{a}\",delimiter=\"#{b}\")"
    p Mapleruby.new(text).exec_i
  end
  def matrixinverse(a)
    main_m :MatrixInverse, a
  end
  def determinant(a)
    main_mf :Determinant, a
  end
  def transpose(a)
    main_m :Transpose, a
  end
  def eigenvectors(a)
    main_m :Eigenvectors, a
  end
  def main_m(name, list_a)
    p name
    p list_a
    puts text = "with(LinearAlgebra): a:=convert(#{list_a},Matrix): evalf(#{name}(a))"
    p Mapleruby.new(text).exec_s
  end
  def main_mf(name, list_a)
    p name
    p list_a
    puts text = "with(LinearAlgebra): a:=convert(#{list_a},Matrix): #{name}(a)"
    p Mapleruby.new(text).exec_f
  end
end

class Mapleruby
  DATA_FILE=File.join(ENV['HOME'],'.mapleruby_rc')
  def initialize(maple_code, *args)
    @args = args
    @maple_code = maple_code
    @src = get_env
    @maple_path=@src[:MAPLE_PATH]
  end
  def exec_i
    result = exec
    return result.to_i
  end
  def exec_f
    result = exec
    return result.to_f
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
  def exec_m(b)
    x = exec.gsub(/[^\d]/, " ")
    x1 = x.split(" ").map(&:to_i)
    result = x1.each_slice(b).to_a
    return result
  end
  def exec
    maple_args=@args.join(',')
    code0=<<EOS
interface(quiet=true);
writeto("./result.txt");
#{@maple_code}(#{maple_args})();
writeto(terminal);
interface(quiet=false);
EOS
    File.write('tmp.mw',code0)
    command="#{@maple_path} tmp.mw"
    status,stdout,stderr=systemu command
    status,stdout,stderr=systemu 'cat result.txt'
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
