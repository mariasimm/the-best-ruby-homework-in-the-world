class Doctor < ApplicationRecord
  paginates_per 50
  belongs_to :department
  belongs_to :speciality
end
