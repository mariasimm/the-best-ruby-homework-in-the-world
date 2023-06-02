class Card < ApplicationRecord
  paginates_per 50
  belongs_to :hospital
  has_one :patient
end
