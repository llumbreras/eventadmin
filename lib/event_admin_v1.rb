require 'csv'

puts "Getting started with Event Admin with CSV parser"

contents = CSV.open("./event_visitors.csv", headers:true, header_converters: :symbol)
contents.each do |content|
	name = content[:first_name]
	zipcode = content[:zipcode]
	puts "#{name}, #{zipcode}"
end
