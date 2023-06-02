class Hospital < ApplicationRecord
  paginates_per 50
  has_many :departments
  has_one :card
  has_one_attached :avatar
end
