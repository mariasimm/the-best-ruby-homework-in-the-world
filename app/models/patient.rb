class Patient < ApplicationRecord
  paginates_per 50
  belongs_to :card
  has_one_attached :avatar
end

