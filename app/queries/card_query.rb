class CardQuery
  def initialize(street, dateB, hospital_id)
    @street = street
    @dateB = dateB
    @hospital_id = hospital_id
  end

  def call
    results = Card.all
    results = results.where("street LIKE ?", "%#{@street}%") if @street
    results = results.where("dateB LIKE ?", "%#{@dateB}%") if @dateB
    results = results.where("hospital_id LIKE ?", "%#{@hospital_id}%") if @hospital_id
    results
  end
end
