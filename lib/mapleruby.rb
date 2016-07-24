require "mapleruby/version"
require 'systemu'
class Mapleruby
  # Your code goes here...
  def initialize(maple_code)
    @maple_code = maple_code
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
    command="/Library/Frameworks/Maple.framework/Versions/Current/bin/maple tmp.mw"
    status,stdout,stderr=systemu command
    status,stdout,stderr=systemu 'cat result.txt'
    p result=stdout.to_i
    return result
  end
end
