class PatientQuery
  def initialize(name, card_id)
    @name = name
    @card_id = card_id
  end

  def call
    results = Patient.all
    results = results.where("name LIKE ?", "%#{@name}%") if @name
    results = results.where("card_id LIKE ?", "%#{@card_id}%") if @card_id
    results
  end
end
