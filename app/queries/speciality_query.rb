class SpecialityQuery
  def initialize(name)
    @name = name
  end

  def call
    results = Speciality.all
    results = results.where("name LIKE ?", "%#{@name}%") if @name
    results
  end
end
