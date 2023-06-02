class DoctorQuery
  def initialize(name, email, phone, department_id, speciality_id)
    @name = name
    @email = email
    @phone = phone
    @department_id = department_id
    @speciality_id = speciality_id
  end

  def call
    results = Doctor.all
    results = results.where("name LIKE ?", "%#{@name}%") if @name
    results = results.where("email LIKE ?", "%#{@email}%") if @email
    results = results.where("phone LIKE ?", "%#{@phone}%") if @phone
    results = results.where("department_id LIKE ?", "%#{@department_id}%") if @department_id
    results = results.where("speciality_id LIKE ?", "%#{@speciality_id}%") if @speciality_id
    results
  end
end
