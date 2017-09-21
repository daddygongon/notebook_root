# -*- coding: utf-8 -*-
require 'colorize'
require 'fileutils'

# search_originals
search_dirs = %w[Github python Desktop]
except_dirs = Regexp.new('eagle12|yuri|naoki')

whole_ipynbs = []
search_dirs.each do |dir|
  files = Dir.glob(File.join(ENV['HOME'], "#{dir}/**/*.ipynb"))
  files.each do |file|
    next if file.match(except_dirs)
    whole_ipynbs << file
  end
end


p whole_ipynbs.size

# list links
linked_ipynbs = {}
link_name = nil

Dir.glob('../**/*.ipynb') do |file|
  begin
    link_name = File.readlink(file)
  rescue => _e
    #    p _e
    next
  end
  linked_ipynbs[file] = link_name
end

p linked_ipynbs.size

# delete correct pair
10.times do # delete during each doesn't work, how do you do?
  whole_ipynbs.each do |source|
    once = false
    linked_ipynbs.each_pair do |key, val|
      if val == source
        once = true unless once
        linked_ipynbs.delete(key)
      end
    end
    whole_ipynbs.delete(source) if once
  end
end

p whole_ipynbs.size
p linked_ipynbs.size

# delete stray files in links
linked_ipynbs.each_pair do |link, file|
  next if File.exist?(file)
  puts file.to_s
  puts "remove #{link} [y/n]?".red
  input = gets.chomp
  FileUtils.rm(link, verbose: true) if input[0] =~ /y|Y/
end

# display unlined files
puts 'Unlinked files:'.blue
whole_ipynbs.each do |file|
  puts "\t#{file}".blue
end
puts ' make links and tidy up.'.blue
