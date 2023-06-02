require 'net/http'
require 'nokogiri'

url = URI.parse('https://www.hospitalsafetygrade.org/all-hospitals')
response = Net::HTTP.get_response(url)

doc = Nokogiri::HTML(response.body)

content_div = doc.css('div.column1')
hospitals = content_div.css('a').map(&:text)

hospitals.each do |hospital|
  Hospital.create(name: hospital)
end
