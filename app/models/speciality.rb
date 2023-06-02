class Speciality < ApplicationRecord
  paginates_per 50
  has_and_belongs_to_many :doctor

end
