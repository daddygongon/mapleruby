# IO.popenを用いた対話的利用法．

```ruby
bob% irb
irb(main):003:0> maple = IO.popen("/Library/Frameworks/Maple.framework/Versions/Current/bin/maple","w+")
=> #<IO:fd 13>
irb(main):004:0> maple.puts '1+1;'
=> nil
irb(main):005:0> maple.gets
=> "    |\\^/|     Maple 2015 (APPLE UNIVERSAL OSX)\n"
irb(main):006:0> maple.gets
=> "._|\\|   |/|_. Copyright (c) Maplesoft, a division of Waterloo Maple Inc. 2015\n"
irb(main):007:0> maple.gets
=> " \\  MAPLE  /  All rights reserved. Maple is a trademark of\n"
irb(main):008:0> maple.gets
=> " <____ ____>  Waterloo Maple Inc.\n"
irb(main):009:0> maple.gets
=> "      |       Type ? for help.\n"
irb(main):010:0> maple.gets
=> "> 1+1;\n"
irb(main):011:0> maple.gets
=> "                                       2\n"
irb(main):012:0> maple.gets
=> "\n"
irb(main):014:0> maple.puts "1+9;"
=> nil
irb(main):015:0> maple.gets
=> "> 1+9;\n"
irb(main):016:0> maple.gets
=> "                                       10\n"
irb(main):017:0> maple.puts "quit;"
=> nil
irb(main):018:0> maple.gets
=> "\n"
irb(main):019:0> maple.gets
=> "> quit;\n"
irb(main):020:0> maple.gets
=> "memory used=0.4MB, alloc=8.3MB, time=0.08\n"
irb(main):021:0> maple.gets
=> nil
irb(main):022:0> maple.close
=> nil
irb(main):023:0> maple.gets
IOError: closed stream
	 from (irb):23:in `gets'
	 from (irb):23
	 from /usr/local/bin/irb:11:in `<main>'
irb(main):024:0> exit
Pipe closed unexpectedly: Shutting down.
Please see ?sigpipe for more details

```
