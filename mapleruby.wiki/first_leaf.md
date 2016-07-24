# 概要
Maplerubyの作り方

# 背景
- なぜmaplerubyが必要か?
- Rubyは数値計算のライブラリー開発が遅れている．
- pythonみたいにgiographicsとかデータ解析，Rを狙うのは．．．
- 得意なシミュレーション分野でほしいもの
  - 正しい答え．これと楽に比較できると便利
  - あるいは少し高等な関数
    - 例えば，nextprime, lcg, なんか．．．

# first step
まずはmaple利用で考えているおおまかな流れを書いておきます．

specを見てください．
```ruby
  it 'returns 1+1=2' do
    p res = Mapleruby.new('1+1').exec
    expect(2).to eq(res)
  end
```
というような使い方を想定しています．

このコードは
```ruby
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
```
で実現されています．

動作の解説は，
1. initializeで要求コードを受け取る
1. execで
  1. code0を生成
  1. tmp.mwにcode0を書き込む
  1. maple tmp.mwで実行
  1. 結果をresult.txtで受け取る
  1. 必要な処理をして，返す

です．これらをコードに応じて自動処理するコードを書くのが，エリンギの仕事です．がんばね．

# rake spec

```diff
Mapleruby
  has a version number
2
2
  returns 1+1=2

Finished in 0.37756 seconds (files took 0.27578 seconds to load)
2 examples, 0 failures
```
all greenデす．いまのとこ．

# 参考とすべきgem
- gnuplot
  - どのようにして外部コマンドのgnuplotを操作しているかを解析すべき
- https://github.com/masoo/ruby-csharp_script
  - ruby関西でcsharpを呼び出すlibraryの開発を発表したはった．
たぶん，開発の細かいところを聞ける．
