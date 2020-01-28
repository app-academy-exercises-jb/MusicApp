class Album < ApplicationRecord
  validates :title, :year, :band_id, :studio, presence: true
  
  belongs_to :band
end
