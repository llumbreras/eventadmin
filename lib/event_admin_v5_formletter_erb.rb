require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "API KEY"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end



puts "EventAdmin getting started."

template_letter = File.read 'formletter.erb'
erb_template = ERB.new template_letter

contents = CSV.open 'event_visitors.csv', headers: true, header_converters: :symbol

contents.each do | content |
	name = content[:first_name]

	zipcode = clean_zipcode(content[:zipcode])

	legislators = legislators_by_zipcode(zipcode)

	form_letter = erb_template.result(binding)
	puts form_letter

end

