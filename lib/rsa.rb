#require 'prime'
require './mapleruby'

def rsa(input)
  c = input.to_i
  print "平文>>> #{c}\n"
  big_num = RMaple.new.rand(999)

  p,q,n=0,0,0
  p = RMaple.new.nextprime(big_num)
  q = RMaple.new.nextprime(big_num)
    
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

  for d in 2..l do
    break if (e*d)%l==1
  end

  print "秘密鍵>>> D = #{d}, N = #{n}\n"

  m = c**e % n
  re_c = m**d % n

  print "暗号化>>> #{m}\n"
  print "復号化>>> #{re_c}\n"
  
 # if re_c!=c then
 #   print c.to_s+"\n"
 #   print n
 #   sleep 3
 # end
end

rsa(ARGV[0])

#100.times{
#  rsa(8000)
#}
