class DepartmentQuery
  def initialize(name, address, phone, hospital_id)
    @name = name
    @address = address
    @phone = phone
    @hospital_id = hospital_id
  end

  def call
    results = Department.all
    results = results.where("name LIKE ?", "%#{@name}%") if @name
    results = results.where("address LIKE ?", "%#{@address}%") if @address
    results = results.where("phone LIKE ?", "%#{@phone}%") if @phone
    results = results.where("hospital_id LIKE ?", "%#{@hospital_id}%") if @hospital_id
    results
  end
end
