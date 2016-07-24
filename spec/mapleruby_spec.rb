require 'spec_helper'

describe Mapleruby do
  it 'has a version number' do
    expect(Mapleruby::VERSION).not_to be nil
  end

  it 'returns 1+1=2' do
    p res = Mapleruby.new('1+1').exec
    expect(2).to eq(res)
  end
end
