class Prefecture < ApplicationRecord
  has_many :sweets
  has_many :user
end
