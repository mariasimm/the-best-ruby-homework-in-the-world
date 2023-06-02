require 'csv'

CSV.foreach('lib/hospitals.csv', headers: true) do |row|
  Hospital.create(name: row['Facility.Name'], address: row['Facility.State'], street: row['Facility.City'])
end
