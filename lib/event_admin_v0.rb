# Read a file and output a column using Ruby
# Without using the Ruby csv parser

puts "Getting started with Event Admin"

contents = File.readlines ("event_visitors.csv")
contents.each_with_index do |content, index|
	next if index == 0
	columns = content.split(",")
	name = columns[2]
	puts name.capitalize
end