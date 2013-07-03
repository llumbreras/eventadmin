require 'csv'

def clean_zipcode(zipcode)
  	if zipcode.nil?
  		zipcode = "00000"
  	elsif zipcode.length < 5
  		zipcode = zipcode.rjust 5, "0"
  	elsif zipcode.length > 5
  		zipcode = zipcode[0..4]
  	else
  		zipcode
  	end
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
