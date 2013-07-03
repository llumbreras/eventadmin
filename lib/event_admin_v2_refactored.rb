require 'csv'

def clean_zipcode(zipcode)
  	zipcode.to_s.rjust(5,"0")[0..4]
end


puts "Getting started with Event Admin(clean zipcode)"

contents = CSV.open("./event_visitors.csv", headers:true, header_converters: :symbol)
contents.each do |content|
	name = content[:first_name]
	zipcode = clean_zipcode(content[:zipcode])

	# if zip code is five digits, ok
 	# if zip code is more than 5 digits, truncate to first 5 digits
  	# if zip code is less than 5 digits, add zeros to front to be five digits

	puts "#{name}, #{zipcode}"
end
