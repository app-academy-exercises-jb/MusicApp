class Album < ApplicationRecord
  validates :title, :year, :band_id, presence: true
  validates_inclusion_of :studio, in: [true, false]
  
  belongs_to :band
end
