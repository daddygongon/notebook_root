require 'json'

first_cell = 0
puts file_name = File.join(Dir.pwd,'README.ipynb')
puts time = Time.now
File.open(file_name) do |file|
  hash = JSON.load(file)
  ele = hash['cells'][first_cell]['source']
  if ele[0].include?(file_name)
    ele << "\n* #{date}\n"
  else
    ele = {"cell_type": "markdown",
      "metadata": {},
      "source": ["* #{File.join(Dir.getwd, file_name)}\n",
                 "* #{date}\n"] }
    hash['cells'].insert(first_cell, ele)
  end
  json_str = JSON.pretty_generate(hash)
  File.open('tmp.json', 'w') { |of| of.puts json_str }
end

