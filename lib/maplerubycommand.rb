require 'mapleruby'
require 'optparse'
require 'yaml'

module MaplerubyCommand
  DATA_FILE=File.join(ENV['HOME'],'.mapleruby_rc')

  class Command
    def self.run(argv=[])
      new(argv).execute
    end

    def initialize(argv=[])
      @argv = argv
      @src={}
    end

    def execute
      @argv << '--help' if @argv.size==0
      command_parser = OptionParser.new do |opt|
        opt.on('-v', '--version','show prgoram versions.'){
          opt.version = Mapleruby::VERSION
          puts opt.ver
        }
        opt.on('-s', '--show','show mapleruby environment.'){
          show_env
        }
        opt.on('-i', '--init','init mapleruby environment.'){
          init_env
        }
      end
      head = <<EOS
Mapleruby is basically a lib used in ruby code,
but command 'mapleruby' provides some helping utils.
Usage: mapleruby [options] FILE
EOS
      command_parser.banner = head
      command_parser.parse!(@argv)
      exit
    end

    def show_env
      print "mapleruby, show_env.\n"
      begin 
        file = File.open(DATA_FILE,'r')
      rescue => evar
        p evar
        print "no resource file for mapleruby.\n"
        print "making ~/.mapleruby_rc...\n"
        init_env
        file = File.open(DATA_FILE,'r')
      end
      @src = YAML.load(file.read)
      file.close
      p @src
    end

    def init_env
      print "mapleruby, init_env.\n"
      if File.exist?(DATA_FILE)
        print "#{DATA_FILE} exists.\n"
        print "Not making new #{DATA_FILE}.\n"
        exit
      end
      begin
        file = File.open(DATA_FILE,'w')
      rescue 
        p evar
        print "could not make #{DATA_FILE}.\n"
        exit
      end
#      @src={:MAPLE_PATH => '/usr/local/bin/maple'}
      @src={:MAPLE_PATH => 
        '/Library/Frameworks/Maple.framework/Versions/Current/bin/maple'}
      YAML.dump(@src, file)
      file.close
    end
  end
end
