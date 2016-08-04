# Mapleruby

rubyからmapleの関数を呼び出すinterface

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mapleruby'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install mapleruby
```

## Usage

Maplerubyはgem libraryで提供されます．

ただし，~/.mapleruby_rcにいくつかの環境設定を保存しています．現在のところ，
```tcsh
bob% cat ~/.mapleruby_rc 
---
:MAPLE_PATH: "/Library/Frameworks/Maple.framework/Versions/Current/bin/maple"
```
だけです．

この環境構築などを担うCUIはexe/maplerubyに用意されています．
構造化データの簡易表現が可能なyamlを使ってデータの読み書きをしています．使い方は
```tcsh
bob% bundle exec exe/mapleruby 
Mapleruby is basically a lib used in ruby code,
but command 'mapleruby' provides some helping utils.
Usage: mapleruby [options] FILE
    -v, --version                    show prgoram versions.
    -s, --show                       show mapleruby environment.
    -i, --init                       init mapleruby environment.
```
のとおりです．


libraryで読んで，
```ruby
require 'mapleruby'

Maple::Eigenvectors(A)
Maple::nextprime(a)
Maple::lcm(a,b)
```
というような使い方を想定しています．

あるいは
```ruby
require 'mapleruby'

Maple.new('Eigenvectors',A)
Maple.new('nextprime',a)
Maple.new('lcm',a,b)
```
かな．．．

結局，
```ruby
require 'mapleruby'

Maple.new('1+1').exe
Maple.new('nextprime',a).exe
Maple.new('lcm',a,b).exe
```
で落ち着きそう．
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/daddygongon/mapleruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
