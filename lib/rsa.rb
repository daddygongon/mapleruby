require './mapleruby'
include Math

def rsa(input)
  c = input.to_i
  print "平文>>> #{c}\n"
  
  big_num = sqrt(c).to_i
  num = 1000
  
  p,q,n=0,0,0
  p = RMaple.new.nextprime(rand(big_num+1..big_num+num))
  q = RMaple.new.nextprime(rand(big_num+1..big_num+num))

  n = p*q
  l = RMaple.new.lcm(p-1,q-1)

  print "素数 p >>> #{p}\n"
  print "素数 q >>> #{q}\n"
  print "N >>> #{n}\n"
  print "L >>> #{l}\n"

  for e in 2..l do
    break if RMaple.new.gcd(e,l)==1
  end

  print "公開鍵>>> E = #{e}, N = #{n}\n"
  
  d = Mapleruby.new("eval(1/#{e} mod #{l})").exec_i

  print "秘密鍵>>> D = #{d}, N = #{n}\n"

  x = Mapleruby.new("#{c}^#{e}").exec_i  
  m = RMaple.new.mod(x, n)
  
  re_c = Mapleruby.new("#{m}^#{d} mod #{n}").exec_i

  print "暗号化>>> #{m}\n"
  print "復号化>>> #{re_c}\n"
end

rsa(ARGV[0])
