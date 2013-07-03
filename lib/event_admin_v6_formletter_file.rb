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

	id = content[0]
	name = content[:first_name]

	zipcode = clean_zipcode(content[:zipcode])

	legislators = legislators_by_zipcode(zipcode)

	form_letter = erb_template.result(binding)

	Dir.mkdir("output") unless Dir.exists? ("output")
	filename = "output/thanks_#{id}.html"

	File.open(filename,'w') do |file|
		file.puts form_letter
	end

end

