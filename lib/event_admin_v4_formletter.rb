require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "API KEY"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
	legislator_name = legislators.collect do |legislator|
		"#{legislator.first_name} #{legislator.last_name}"
	end
	legislator_string = legislator_name.join(",")
end



puts "EventAdmin getting started."

template_letter = File.read 'formletter.html'

contents = CSV.open 'event_visitors.csv', headers: true, header_converters: :symbol

contents.each do | content |
	name = content[:first_name]

	zipcode = clean_zipcode(content[:zipcode])

	legislators = legislators_by_zipcode(content[:zipcode])

	personal_letter = template_letter.gsub('FIRST_NAME', name)
	personal_letter = personal_letter.gsub('LEGISLATORS', legislators)

	puts personal_letter
end

