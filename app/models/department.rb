class Department < ApplicationRecord
  paginates_per 50
  belongs_to :hospital
  has_many :doctor
end
