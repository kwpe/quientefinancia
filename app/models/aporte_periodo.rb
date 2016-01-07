class AportePeriodo < ApplicationRecord
  belongs_to :periodo
  has_many :aportes
end
