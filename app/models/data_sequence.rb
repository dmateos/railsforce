class DataSequence < ApplicationRecord
  belongs_to :graph
  validates :graph, presence: true
  validates :data, presence: true
end
