#!/usr/bin/env ruby
require 'json'

ipynb = JSON.load(File.read(ARGV[0]))
ipynb.each do |cells|
  next unless cells.include?("cells")
  cells[1].each do |cell|
    cell["source"].each do |line|
      print line
    end
  end
end

