class HospitalQuery
  def initialize(name, address, phone, street)
    @name = name
    @address = address
    @phone = phone
    @street = street
  end

  def call
    results = Hospital.all
    results = results.where("name LIKE ?", "%#{@name}%") if @name
    results = results.where("address LIKE ?", "%#{@address}%") if @address
    results = results.where("phone LIKE ?", "%#{@phone}%") if @phone
    results = results.where("street LIKE ?", "%#{@street}%") if @street
    results
  end
end
