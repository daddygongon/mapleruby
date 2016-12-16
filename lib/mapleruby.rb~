require "mapleruby/version"
require 'systemu'
require 'yaml'

class RMaple
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
  def importmatrix(a,b)
    p a
    p b
    puts text = "ImportMatrix(\"#{a}\",delimiter=\"#{b}\")"
    p Mapleruby.new(text).exec_s
  end
  def exportmatrix(a,b,c)
    p a
    p b
    p c
    #ExportMatrix("ExportData.csv", data, delimite=" ")
    puts text = "ExportMatrix(\"#{a}\",#{b},delimiter=\"#{c}\")"
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





